module Commentable
  module InstanceMethods
    def add_comment(options = {})
      comments.create(options)
    end
  end
end
