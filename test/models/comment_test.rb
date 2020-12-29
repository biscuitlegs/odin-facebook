require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should not save without a user" do
    comment = Comment.new
    comment.body = "a" * 20
    comment.post = posts(:hello_world)
    assert_not comment.save, "Comment saved without a user."
  end

  test "should not save without a post" do
    comment = Comment.new
    comment.body = "a" * 20
    comment.user = users(:david)
    assert_not comment.save, "Comment saved without a post."
  end

  test "should not save without an existing user" do
    comment = Comment.new
    comment.body = "a" * 20
    comment.user_id = 0
    comment.post = posts(:hello_world)
    assert_not comment.save, "Comment saved without an existing user."
  end

  test "should not save without an existing post" do
    comment = Comment.new
    comment.body = "a" * 20
    comment.user = users(:david)
    comment.post_id = 0
    assert_not comment.save, "Comment saved without an existing post."
  end

  test "should save with an existing user and post" do
    comment = Comment.new
    comment.body = "a" * 20
    comment.user = users(:david)
    comment.post = posts(:hello_world)
    assert comment.save, "Comment did not save with an existing user and post."
  end

  test "should not save without a body" do
    comment = Comment.new
    comment.user = users(:david)
    comment.post = posts(:hello_world)
    assert_not comment.save, "Comment saved without a body."
  end

  test "should not save if body has less than 5 characters" do
    comment = Comment.new
    comment.user = users(:david)
    comment.post = posts(:hello_world)
    comment.body = "a" * 4
    assert_not comment.save, "Comment saved with less than 5 characters."
  end

  test "should not save if body has more than 150 characters" do
    comment = Comment.new
    comment.user = users(:david)
    comment.post = posts(:hello_world)
    comment.body = "a" * 151
    assert_not comment.save, "Comment saved with more than 150 characters."
  end

  test "should save with a valid body length" do
    comment = Comment.new
    comment.user = users(:david)
    comment.post = posts(:hello_world)
    comment.body = "a" * 15
    assert comment.save, "Comment did not save with a valid body length."
  end

  test "calling #user on a comment returns the comment's user" do
    assert comments(:great_post).user == users(:mark)
  end

  test "calling #post on a comment returns the comment's post" do
    assert comments(:great_post).post == posts(:hey_guys)
  end
end