class Comment < ActiveRecord::Base
  # associations
  belongs_to :commentable, 
    :polymorphic => true, 
    :counter_cache => true
  
  belongs_to :user
  
  # validations
  validates_presence_of :comment
  
  validates_presence_of :user_id, :user
  
  validates_uniqueness_of :comment,
    :scope => [:commentable_type, :commentable_id, :user_id],
    :message => 'is duplicated'
end