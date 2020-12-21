require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should not save without a user" do
    post = Post.new
    post.body = "a" * 25
    assert_not post.save, "Post saved without a user."
  end

  test "should not save with a non-existant user" do
    post = Post.new
    post.user_id = 0
    post.body = "a" * 25
    assert_not post.save, "Post saved with a non-existant user."
  end

  test "should save with an existing user" do
    post = Post.new
    post.user = users(:david)
    post.body = "a" * 25
    assert post.save, "Post did not save with an existing user."
  end

  test "should not save without a body" do
    post = Post.new
    post.user = users(:david)
    assert_not post.save, "Post saved without a body."
  end

  test "should not save if body has less than 5 characters" do
    post = Post.new
    post.user = users(:david)
    post.body = "a" * 4
    assert_not post.save, "Post saved with when body has less than 5 characters."
  end

  test "should not save if body has more than 100 characters" do
    post = Post.new
    post.user = users(:david)
    post.body = "a" * 101
    assert_not post.save, "Post saved with when body has more than 100 characters."
  end

  test "should save with a valid body length" do
    post = Post.new
    post.user = users(:david)
    post.body = "Hello!"
    assert post.save, "Post did not save when body length is valid."
  end
end
