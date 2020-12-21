require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  test "should save with a valid friend one and friend two" do
    friendship = Friendship.new
    friendship.friend_one = users(:david)
    friendship.friend_two = users(:emma)
    assert friendship.save, "Friendship did not save with a valid friend one and friend two."
  end

  test "should not save without a friend one" do
    friendship = Friendship.new
    friendship.friend_two = users(:emma)
    assert_not friendship.save, "Friendship saved without a friend one."
  end

  test "should not save without a friend two" do
    friendship = Friendship.new
    friendship.friend_one = users(:david)
    assert_not friendship.save, "Friendship saved without a friend two."
  end

  test "should not save with an invalid friend one" do
    friendship = Friendship.new
    friendship.friend_one_id = 0
    friendship.friend_two = users(:emma)
    assert_not friendship.save, "Friendship saved with an invalid friend one."
  end

  test "should not save with an invalid friend two" do
    friendship = Friendship.new
    friendship.friend_one = users(:david)
    friendship.friend_two_id = 0
    assert_not friendship.save, "Friendship saved with an invalid friend two."
  end
end
