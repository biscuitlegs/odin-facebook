require 'test_helper'

class CommentFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "user can see their own comments" do
    sign_in users(:mark)
    get "/posts"
    assert_response :success
    assert_select "p", comments(:great_post).body
  end

  test "user can see other users's comments" do
    sign_in users(:mark)
    get "/posts"
    assert_response :success
    assert_select "p", comments(:incredible).body
  end

  test "user can create a comment" do
    sign_in users(:mark)
    post "/comments",
      params: { comment: { body: "I'm a comment created by Mark!", post_id: posts(:hey_guys).id } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "I'm a comment created by Mark!"
  end
end
