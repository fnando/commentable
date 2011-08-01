module Commentable
  module ClassMethods
    def commentable(options = {})
      self.commentable_options = options
      has_many :comments, :as => :commentable, :dependent => :destroy
    end
  end
end
