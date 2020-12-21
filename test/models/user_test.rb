require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save without a first_name" do
    user = User.new
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user without a first name."
  end

  test "should not save without a last_name" do
    user = User.new
    user.first_name = "John"
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user without a last name."
  end

  test "should not save without an email" do
    user = User.new
    user.first_name = "John"
    user.last_name = "Johnson"
    user.password = "password"
    assert_not user.save, "Saved user without an email."
  end

  test "should not save without a password" do
    user = User.new
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    assert_not user.save, "Saved user without a password."
  end

  test "should not save with a blank email" do
    user = User.new
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = ""
    user.password = "password"
    assert_not user.save, "Saved user with a blank email."
  end

  test "should not save with a blank first name" do
    user = User.new
    user.first_name = ""
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user with a blank first name."
  end

  test "should not save with a blank last name" do
    user = User.new
    user.first_name = "John"
    user.last_name = ""
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user with a blank last name."
  end

  test "should not save with a blank password" do
    user = User.new
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    assert_not user.save, "Saved user with a blank last name."
  end

  test "should not save if first name has more than 15 characters" do
    user = User.new
    user.first_name = "a" * 16
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user first name with more than 15 characters."
  end

  test "should not save if last name has more than 15 characters" do
    user = User.new
    user.first_name = "John"
    user.last_name = "a" * 16
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user last name with more than 15 characters."
  end

  test "should not save if email has more than 30 characters" do
    user = User.new
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email =  ("a" * 31) + "@example.com"
    user.password = "password"
    assert_not user.save, "Saved user email with more than 30 characters."
  end

  test "should not save if password has less than 6 characters" do
    user = User.new
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "12345"
    assert_not user.save, "Saved user password with less than 6 characters."
  end

  test "should not save if password has more than 12 characters" do
    user = User.new
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "a" * 13
    assert_not user.save, "Saved user password with more than 12 characters."
  end

  test "should not save if password does not contain a numeric character" do
    user = User.new
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "johnson@example.com"
    user.password = "password"
    assert_not user.save, "Saved user password without a numeric character."
  end

  test "should not save if email is not unique" do
    user = User.new
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = users(:david).email
    user.password = "password123"
    assert_not user.save, "Saved user email when not unique."
  end

  test "should save if first name, last name, password and email are valid" do
    user = User.new
    user.first_name = "John"
    user.last_name = "Johnson"
    user.email = "john@example.com"
    user.password = "password1"
    assert user.save, "Did not save user when first name, last name, email and password are valid."
  end
end
