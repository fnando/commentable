require "spec_helper"

describe Comment do
  let(:user) { User.create }
  let(:project) { Project.create }
  let(:task) { Task.create }
  subject { project.add_comment(:body => "Some comment", :user => user) }

  context "validations" do
    it "requires body" do
      subject.body = nil
      subject.valid?
      subject.errors[:body].should_not be_empty
    end

    it "requires user" do
      subject.user = nil
      subject.valid?
      subject.errors[:user].should_not be_empty
    end
  end

  context "associations" do
    its(:user) { should be_an(User) }
    its(:commentable) { should be_a(Project) }
  end

  context "counter" do
    it "increments counter" do
      expect {
        project.add_comment(:body => "Some comment", :user => user)
      }.to change { project.reload.comments_count }.by(1)
    end
  end

  context "formatting" do
    it "saves formatted body" do
      subject = task.comments.create(:body => "# Commentable", :user => user)
      subject.formatted_body.should include("<h1>Commentable</h1>")
    end
  end

  context "removing" do
    let(:user) { User.create }
    let(:task) { Task.create }
    let(:comment) { task.add_comment(:body => "Some comment", :user => user) }

    it "nullifies existing records when user is removed" do
      user.destroy
      comment.reload.user.should be_nil
    end

    it "removes existing records when commentable is removed" do
      task.destroy
      Comment.where(:commentable_id => task.id, :commentable_type => task.class.name).count.should be_zero
    end
  end
end
