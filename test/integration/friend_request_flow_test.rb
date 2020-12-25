require 'test_helper'

class FriendRequestFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "user can send a friend request" do
    sign_in users(:mark)
    post "/friend_requests",
      params: { friend_request: { sending_user_id: users(:mark).id, receiving_user_id: users(:emma).id } }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    get "/friend_requests"
    assert_select "p", users(:emma).full_name
  end

  test "user can see received friend requests" do
    sign_in users(:emma)
    get "/friend_requests"
    assert_select "p", users(:david).full_name
  end

  test "user can accept received friend requests" do
    sign_in users(:emma)
    post "/friendships",
      params: { 
        friendship: { 
          friend_one_id: users(:david).id, 
          friend_two_id: users(:emma).id }, 
        friend_request_id: friend_requests(:david_to_emma).id
      }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    
    get "/friends"
    assert_response :success
    assert_select "p", users(:david).full_name
  end

  test "user can decline received friend requests" do
    sign_in users(:emma)
    delete "/friend_requests/#{friend_requests(:david_to_emma).id}"
    assert_response :redirect
    follow_redirect!
    assert_response :success
    
    get "/friend_requests"
    assert_response :success
    assert_select "p", { text: users(:david).full_name, count: 0}
  end

  test "user can not send a friend request from another user" do
    sign_in users(:mark)
    post "/friend_requests",
      params: { friend_request: { sending_user_id: users(:emma).id, receiving_user_id: users(:mark).id } }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    get "/friend_requests"
    assert_select "p", { text: users(:emma).full_name, count: 0 }
  end

  test "user can not accept another users's received friend requests" do
    sign_in users(:mark)
    post "/friendships",
      params: { 
        friendship: { 
          friend_one_id: users(:david).id, 
          friend_two_id: users(:emma).id }, 
        friend_request_id: friend_requests(:david_to_emma).id
      }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    
    assert FriendRequest.where(sending_user_id: users(:david).id, receiving_user_id: users(:emma).id).any?
  end

  test "user can not decline another users's received friend requests" do
    sign_in users(:mark)
    delete "/friend_requests/#{friend_requests(:david_to_emma).id}"
    assert_response :redirect
    follow_redirect!
    assert_response :success
    
    assert FriendRequest.where(sending_user_id: users(:david).id, receiving_user_id: users(:emma).id).any?
  end

end
