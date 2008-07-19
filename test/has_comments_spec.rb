require "spec_helper"

# unset models used for testing purposes
Object.unset_class('User', 'Beer', 'Donut')

class User < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
end

class Beer < ActiveRecord::Base
  has_comments
end

class Donut < ActiveRecord::Base
  has_comments
end

describe "has_comments" do
  fixtures :users, :beers, :donuts
  
  before(:each) do
    @user = users(:homer)
    @another_user = users(:barney)
    @beer = beers(:duff)
    @donut = donuts(:cream)
  end
  
  it "should have comments association" do
    lambda { @beer.comments }.should_not raise_error
    lambda { @donut.comments }.should_not raise_error
  end
  
  it "should create a comment with <user> object" do
    lambda do
      @beer.comment(:user => @user, :comment => "The best beer ever!")
    end.should change(Comment, :count).by(1)
  end
  
  it "should create a comment with :user_id attribute" do
    lambda do
      @beer.comment(:user_id => @user.id, :comment => "The best beer ever!")
    end.should change(Comment, :count).by(1)
  end
  
  it "should require comment" do
    lambda do
      comment = @beer.comment(:user => @user, :comment => nil)
      comment.errors.on(:comment).should_not be_nil
    end.should_not change(Comment, :count)
  end
  
  it "should require user" do
    lambda do
      comment = @beer.comment(:user => nil, :comment => "The best beer ever!")
      comment.errors.on(:user).should_not be_nil
      
      comment = @beer.comment(:user_id => nil, :comment => "The best beer ever!")
      comment.errors.on(:user).should_not be_nil
    end.should_not change(Comment, :count)
  end
  
  it "should deny duplicated comments with object as scope" do
    lambda do
      comment = @beer.comment(:user => @user, :comment => "The best beer ever!")
      comment.should be_valid
      
      another_comment = @beer.comment(:user => @user, :comment => "The best beer ever!")
      another_comment.should_not be_valid
    end.should change(Comment, :count).by(1)
  end
  
  it "should create comments with same text for different objects" do
    lambda do
      comment = @beer.comment(:user => @user, :comment => "Great!")
      comment.should be_valid
      
      another_comment = @donut.comment(:user => @user, :comment => "Great!")
      another_comment.should be_valid
    end.should change(Comment, :count).by(2)
  end
  
  it "should create comments with same text for different objects with different users" do
    lambda do
      comment = @beer.comment(:user => @user, :comment => "Great!")
      comment.should be_valid
      
      another_comment = @beer.comment(:user => @another_user, :comment => "Great!")
      another_comment.should be_valid
    end.should change(Comment, :count).by(2)
  end
  
  it "should get unique users that commented on duff" do
    @beer.comment(:user => @user, :comment => "Great!")
    @beer.comment(:user => @user, :comment => "Cool!")
    @beer.comment(:user => @another_user, :comment => "Yay!")
    
    @beer.find_users_that_commented.should == [@user, @another_user]
  end
  
  it "should get users that commented only on duff" do
    @beer.comment(:user => @user, :comment => "Great!")
    @donut.comment(:user => @another_user, :comment => "Yay!")
    
    @beer.find_users_that_commented.should == [@user]
  end
  
  it "should get comments from a given user" do
    comment = @beer.comment(:user => @user, :comment => "Great!")
    another_comment = @beer.comment(:user => @user, :comment => "Cool!")
    one_more_comment = @donut.comment(:user => @user, :comment => "Yay!")
    
    @beer.find_comments_by_user(@user).should == [comment, another_comment]
  end
end