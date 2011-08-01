class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  belongs_to :user

  validates_presence_of :body
  validates_presence_of :user, :commentable

  before_save :generate_formatted_body

  private
  def generate_formatted_body
    formatter = commentable.class.commentable_options[:format]
    write_attribute :formatted_body, formatter.call(self) if formatter.respond_to?(:call)
  end
end
