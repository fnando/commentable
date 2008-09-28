has_comments
============

Instalation
-----------

1) Install the plugin with `script/plugin install git://github.com/fnando/has_comments.git`

2) Generate a migration with `script/generate migration create_comments` and add the following code:

	class CreateComments < ActiveRecord::Migration
	  def self.up
	    create_table :comments do |t|
	      t.text :comment
	      t.references :commentable, :polymorphic => true
	      t.references :user
	      t.timestamps
	    end
    
	    add_index :comments, :commentable_type
	    add_index :comments, :commentable_id
	    add_index :comments, :user_id
	  end

	  def self.down
	    drop_table :comments
	  end
	end

3) Run the migrations with `rake db:migrate`

Usage
-----

1) Add the method call `has_comments` to your model.

	class Photo < ActiveRecord::Base
	  has_comments
	end

2) Add this association on your User model:

	class User < ActiveRecord::Base
	  has_many :comments, :dependent => :destroy
	end

	photo = Photo.find(:first)
	user = User.find(:first)

	photo.comment(:user => user, :comment => 'Wow! Nice shot!') # => <comment>
	photo.comments # => [<comment>]
	photo.find_users_that_commented # => [<user>]
	photo.find_comments_by_user(user) # => [<comment>]

NOTE: You should have a User model. You should also have a `comments_count`
column on your model. **Otherwise, this won't work!**

Copyright (c) 2008 Nando Vieira, released under the MIT license