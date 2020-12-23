require 'test_helper'

class PostFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "user can see their own posts" do
    sign_in users(:mark)

    get "/posts"
    assert_response :success

    assert_select "p", "Hello, world!"
  end

  test "user can see other users's posts" do
    sign_in users(:mark)

    get "/posts"
    assert_response :success

    assert_select "p", "Hey guys!"
  end

  test "user can create a post" do
    sign_in users(:mark)

    post "/posts",
      params: { post: { body: "I was created by Mark!" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "I was created by Mark!"
  end

  test "user can delete their own post" do
    sign_in users(:mark)
    get "/posts"
    assert_response :success
    assert_select "p", "Hello, world!"
    
    delete "/posts/#{posts(:hello_world).id}"
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", {count: 0, text: "Hello, world!"}
  end

  test "user can update their own post" do
    sign_in users(:mark)
    get "/posts"
    assert_response :success
    assert_select "p", "Hello, world!"

    patch "/posts/#{posts(:hello_world).id}",
      params: { post: { body: "Greetings, world!" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "Greetings, world!"
  end

  test "user can not delete other users's posts" do
    sign_in users(:mark)
    get "/posts"
    assert_response :success
    assert_select "p", "Hello, world!"
    
    delete "/posts/#{posts(:hey_guys).id}"
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "Hello, world!"
  end

  test "user can not update other user's posts" do
    sign_in users(:mark)
    get "/posts"
    assert_response :success
    assert_select "p", "Hey guys!"

    patch "/posts/#{posts(:hey_guys).id}",
      params: { post: { body: "I updated this post!" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "Hey guys!"
  end
end
