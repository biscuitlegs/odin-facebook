require 'test_helper'

class LikeFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  test "user can like a post" do
    sign_in users(:mark)
    post "/likes",
      params: { like: { user_id: users(:mark).id, post_id: posts(:hey_guys).id } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "span.is-like", text: "1"
  end

  test "user can unlike a post" do
    sign_in users(:david)
    get "/posts"
    assert_response :success
    assert_select "span.is-like", text: "2"

    delete "/likes/#{likes(:david_like_hello_world).id}"
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "span.is-like", text: "1"
  end

  test "user can not like a post as another user" do
    sign_in users(:mark)
    get "/posts"
    assert_select "span.is-like", text: "0"
    
    post "/likes",
      params: { like: { user_id: users(:david).id, post_id: posts(:hey_guys).id } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "span.is-like", text: "0"
  end

  test "user can not unlike a post as another user" do
    sign_in users(:mark)
    get "/posts"
    assert_response :success
    assert_select "span.is-like", text: "2"

    delete "/likes/#{likes(:david_like_hello_world).id}"
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "span.is-like", text: "2"
  end
end
