require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase
  test "should not save if sending user and receiving user are not a unique pair" do
    saved_friend_request = FriendRequest.new
    saved_friend_request.sending_user = users(:emma)
    saved_friend_request.receiving_user = users(:david)
    saved_friend_request.save

    new_friend_request = FriendRequest.new
    new_friend_request.sending_user = users(:david)
    new_friend_request.receiving_user = users(:emma)
    assert_not new_friend_request.save, "Friend Request saved without having a unique friend pair."
  end

  test "should not save without a sending user" do
    friend_request = FriendRequest.new
    friend_request.receiving_user = users(:emma)
    assert_not friend_request.save, "Friend Request saved without a sending user."
  end

  test "should not save without a receiving user" do
    friend_request = FriendRequest.new
    friend_request.sending_user = users(:david)
    assert_not friend_request.save, "Friend Request saved without a receiving user."
  end

  test "should not save if sending user does not exist" do
    friend_request = FriendRequest.new
    friend_request.sending_user_id = 0
    friend_request.receiving_user = users(:emma)
    assert_not friend_request.save, "Friend Request saved with a non-existant sending user."
  end

  test "should not save if receiving user does not exist" do
    friend_request = FriendRequest.new
    friend_request.sending_user_id = users(:david)
    friend_request.receiving_user_id = 0
    assert_not friend_request.save, "Friend Request saved with a non-existant receiving user."
  end

  test "should save if sending and receiving users are a unique pair" do
    friend_request = FriendRequest.new
    friend_request.sending_user = users(:david)
    friend_request.receiving_user = users(:emma)
    assert friend_request.save, "Friend Request saved with a non-unique user pair."
  end
end
