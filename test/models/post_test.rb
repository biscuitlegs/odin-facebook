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

  test "should not save if body has more than 250 characters" do
    post = Post.new
    post.user = users(:david)
    post.body = "a" * 251
    assert_not post.save, "Post saved with when body has more than 250 characters."
  end

  test "should save with a valid body length" do
    post = Post.new
    post.user = users(:david)
    post.body = "Hello!"
    assert post.save, "Post did not save when body length is valid."
  end

  test "should save with an image attached" do
    post = Post.new
    post.user = users(:david)
    post.body = "Hello!"
    post.image.attach(io: File.open('db/seed_images/david.jpg'), filename: 'david.jpg', content_type: 'image/jpg')
    assert post.save, "Post did not save when an image is attached."
  end

  test "calling #user on post should return that post's user" do
    assert posts(:hello_world).user == users(:mark)
  end

  test "calling #comments on post should return that post's comments" do
    assert_includes posts(:hello_world).comments, comments(:incredible)
  end

  test "calling #likes_from_users on post should return that post's likes" do
    assert_includes posts(:hello_world).likes_from_users, users(:emma)
  end
end
