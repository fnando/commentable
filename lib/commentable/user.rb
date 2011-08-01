class User < ActiveRecord::Base
  has_many :comments, :dependent => :nullify
end
