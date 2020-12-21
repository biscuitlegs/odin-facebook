require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  test "should save with a valid user and post" do
    like = Like.new
    like.user_id = users(:david).id
    like.post_id = posts(:hello_world).id
    assert like.save, "Like did not save with a valid user and post."
  end

  test "should not save without a user" do
    like = Like.new
    like.post_id = posts(:hello_world).id
    assert_not like.save, "Like saved without a user."
  end

  test "should not save without a post" do
    like = Like.new
    like.user_id = users(:david).id
    assert_not like.save, "Like saved without a post."
  end

  test "should not save with a non-existant user" do
    like = Like.new
    like.user_id = 0
    like.post_id = posts(:hello_world).id
    assert_not like.save, "Like saved with a non-existant user."
  end

  test "should not save with a non-existant post" do
    like = Like.new
    like.user_id = users(:david).id
    like.post_id = 0
    assert_not like.save, "Like saved with a non-existant post."
  end
end
