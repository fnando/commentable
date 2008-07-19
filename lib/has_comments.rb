module SimplesIdeias
  module Acts
    module Comments
      def self.included(base)
        base.extend SimplesIdeias::Acts::Comments::ClassMethods
        
        class << base
          attr_accessor :has_comments_options
        end
      end
      
      module ClassMethods
        def has_comments
          self.has_comments_options = {
            :type => ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
          }
          
          # associations
          has_many :comments, :as => :commentable, :dependent => :destroy
          
          include SimplesIdeias::Acts::Comments::InstanceMethods
        end
      end
      
      module InstanceMethods
        def find_comments_by_user(owner)
          owner = owner.id if owner.is_a?(User)
          self.comments.find(:all, :conditions => {:user_id => owner})
        end
        
        def comment(options)
          self.comments.create(options)
        end
        
        def find_users_that_commented(options={})
          options = {
            :limit => 20,
            :conditions => ["comments.commentable_type = ? and comments.commentable_id = ?", self.class.has_comments_options[:type], self.id],
            :include => :comments
          }.merge(options)

          User.find(:all, options)
        end
      end
    end
  end
end