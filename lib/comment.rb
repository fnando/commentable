class Comment < ActiveRecord::Base
  # constants
  MESSAGES = {
    :comment_is_required => "is required",
    :user_is_required => "is required",
    :has_already_commented => "is duplicated"
  }
  
  # associations
  belongs_to :commentable, 
    :polymorphic => true, 
    :counter_cache => true
  
  belongs_to :user
  
  # validations
  validates_presence_of :comment,
    :message => MESSAGES[:comment_is_required]
  
  validates_presence_of :user_id, :user,
    :message => MESSAGES[:user_is_required]
  
  validates_uniqueness_of :comment,
    :scope => [:commentable_type, :commentable_id, :user_id],
    :message => MESSAGES[:has_already_commented]
end