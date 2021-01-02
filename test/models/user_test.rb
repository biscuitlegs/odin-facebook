require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save without a username" do
    user = User.new
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user without a username."
  end

  test "should not save without a first_name" do
    user = User.new
    user.username = "johnson342"
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user without a first name."
  end

  test "should not save without a last_name" do
    user = User.new
    user.username = "johnson342"
    user.first_name = "John"
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user without a last name."
  end

  test "should not save without an email" do
    user = User.new
    user.username = "johnson342"
    user.first_name = "John"
    user.last_name = "Johnson"
    user.password = "password"
    assert_not user.save, "Saved user without an email."
  end

  test "should not save without a password" do
    user = User.new
    user.username = "johnson342"
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    assert_not user.save, "Saved user without a password."
  end

  test "should not save with a blank username" do
    user = User.new
    user.username = ""
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user with a blank email."
  end

  test "should not save with a blank email" do
    user = User.new
    user.username = "johnson342"
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = ""
    user.password = "password"
    assert_not user.save, "Saved user with a blank email."
  end

  test "should not save with a blank first name" do
    user = User.new
    user.username = "johnson342"
    user.first_name = ""
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user with a blank first name."
  end

  test "should not save with a blank last name" do
    user = User.new
    user.username = "johnson342"
    user.first_name = "John"
    user.last_name = ""
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user with a blank last name."
  end

  test "should not save with a blank password" do
    user = User.new
    user.username = "johnson342"
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    assert_not user.save, "Saved user with a blank last name."
  end

  test "should not save if username has more than 25 characters" do
    user = User.new
    user.username = "a" * 26
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved username with more than 25 characters."
  end

  test "should not save if first name has more than 15 characters" do
    user = User.new
    user.username = "johnson342"
    user.first_name = "a" * 16
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user first name with more than 15 characters."
  end

  test "should not save if last name has more than 15 characters" do
    user = User.new
    user.username = "johnson342"
    user.first_name = "John"
    user.last_name = "a" * 16
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user last name with more than 15 characters."
  end

  test "should not save if email has more than 30 characters" do
    user = User.new
    user.username = "johnson342"
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email =  ("a" * 31) + "@example.com"
    user.password = "password"
    assert_not user.save, "Saved user email with more than 30 characters."
  end

  test "should not save if username has less than 5 characters" do
    user = User.new
    user.username = "a" * 4
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved username with less than 25 characters."
  end

  test "should not save if password has less than 6 characters" do
    user = User.new
    user.username = "johnson342"
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "12345"
    assert_not user.save, "Saved user password with less than 6 characters."
  end

  test "should not save if password has more than 12 characters" do
    user = User.new
    user.username = "johnson342"
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "a" * 13
    assert_not user.save, "Saved user password with more than 12 characters."
  end

  test "should not save if password does not contain a numeric character" do
    user = User.new
    user.username = "johnson342"
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user password without a numeric character."
  end

  test "should not save if email is not unique" do
    user = User.new
    user.username = "johnson342"
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = users(:david).email
    user.password = "password123"
    assert_not user.save, "Saved user email when not unique."
  end

  test "should save if username, first name, last name, password and email are valid" do
    user = User.new
    user.username = "johnson342"
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "john@example.com"
    user.password = "password1"
    assert user.save, "Did not save user when username, first name, last name, email and password are valid."
  end

  test "calling #posts on user should return that user's posts" do
    assert_includes users(:mark).posts, posts(:hello_world)
  end

  test "calling #comments on user should return that user's comments" do
    assert_includes users(:mark).comments, comments(:great_post)
  end

  test "calling #liked_posts on user should return that user's liked posts" do
    assert_includes users(:emma).liked_posts, posts(:hello_world)
  end

  test "calling #friends on user should return that user's friends" do
    assert_includes users(:emma).friends, users(:david)
  end

  test "calling #received_friend_requests on user should return that user's received friend requests" do
    assert_includes users(:emma).received_friend_requests, friend_requests(:david_to_emma)
  end

  test "calling #sent_friend_requests on user should return that user's sent friend requests" do
    assert_includes users(:david).sent_friend_requests, friend_requests(:david_to_emma)
  end
end
