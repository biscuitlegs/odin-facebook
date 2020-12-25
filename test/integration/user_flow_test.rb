require 'test_helper'

class UserFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  test "user can create an account" do
    post "/users",
      params: { 
        user: {
          first_name: "Kevin", 
          last_name: "Kevinson", 
          email: "kevin@example.com", 
          password: "password1"
        }
      }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "user can delete their account" do
    sign_in users(:mark)
    delete "/users"
    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_not User.where(first_name: "Mark").any?
  end
end
