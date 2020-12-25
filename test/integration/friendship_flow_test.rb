require 'test_helper'

class FriendshipFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  test "user can unfriend a friend" do
    sign_in users(:mark)
    delete "/friendships/#{friendships(:mark_and_david).id}"
    assert_response :redirect
    follow_redirect!
    assert_response :success

    get "/friends"
    assert_response :success

    assert_select "p", { text: users(:david).full_name, count: 0 }
  end

  test "user can not unfriend other users's friends" do
    sign_in users(:mark)
    delete "/friendships/#{friendships(:david_and_emma).id}"
    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert Friendship.where(friend_one_id: users(:david).id, friend_two_id: users(:emma).id).any?
  end
end
