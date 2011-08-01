ActiveRecord::Schema.define(:version => 0) do
  create_table :comments do |t|
    t.text :body, :formatted_body
    t.references :commentable, :polymorphic => true
    t.references :user
    t.timestamps
  end

  add_index :comments, [:commentable_id, :commentable_type], :name => "index_on_commentable"
  add_index :comments, [:commentable_id, :commentable_type, :user_id], :name => "index_on_commentable_and_user"

  create_table :projects do |t|
    t.integer :comments_count, :null => false, :default => 0
  end

  create_table :tasks do |t|
    t.integer :comments_count, :null => false, :default => 0
  end

  create_table :lists do |t|
    t.integer :comments_count, :null => false, :default => 0
  end

  create_table :users do |t|
  end
end
