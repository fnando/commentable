ActiveRecord::Schema.define(:version => 0) do
  create_table :users do |t|
    t.string :name
  end
  
  create_table :beers do |t|
    t.string :name
    t.integer :comments_count, :default => 0, :null => false
  end
  
  create_table :donuts do |t|
    t.string :flavor
    t.integer :comments_count, :default => 0, :null => false
  end
  
  create_table :comments do |t|
    t.text :comment
    t.references :commentable, :polymorphic => true
    t.references :user
    t.timestamps
  end
end