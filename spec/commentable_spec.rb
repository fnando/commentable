require "spec_helper"

describe Commentable do
  let(:user) { User.create }
  let(:project) { Project.create }

  it "injects association" do
    Project.new.should respond_to(:comments)
    Task.new.should respond_to(:comments)
  end

  it "skips association" do
    List.new.should_not respond_to(:comments)
  end

  it "adds new comment shortcut" do
    project.comments.should_receive(:create).with(:body => "Some comment", :user => user)
    project.add_comment(:body => "Some comment", :user => user)
  end
end
