require "active_record"
require "commentable/comment"
require "commentable/user"

module Commentable
  autoload :Version, "commentable/version"
  autoload :InstanceMethods, "commentable/instance_methods"
  autoload :ClassMethods, "commentable/class_methods"

  def self.extended(base)
    base.class_eval do
      include InstanceMethods
      extend ClassMethods

      class << self
        attr_accessor :commentable_options
      end
    end
  end
end

ActiveRecord::Base.extend(Commentable)
