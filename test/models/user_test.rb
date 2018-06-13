require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup 
  	@user = User.new(username:"Mathew", email: "emerson@example.com",
  					password: "mypassword", password_confirmation: "mypassword")
  	@user2 = users(:two)
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "username should be present" do
  	@user.username = ""
  	assert_not @user.valid?
  end

  test "username should be unique" do 
  	@user.username = @user2.username.upcase
  	assert_not @user.valid?
  end

  test "maximum length of username is 20 characters" do
  	@user.username = "a7"*10+"a"
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = ""
  	assert_not @user.valid?
  end

  test "email addresses should be unique" do 
  	@user.email = @user2.email.upcase
  	assert_not @user.valid?
  end

  test "email has invalid format" do 
  	@user.email = "ssushii@gmail"
  	assert !@user.valid?
  end

  test "email addresses should be saved as lower-case" do
  	mixed_case_email = "HELLOmoto@eXAMPLE.com"
  	@user.email = mixed_case_email
  	@user.save
  	assert_equal mixed_case_email.downcase, @user.email
  end

  test "password should be present(nonblank)" do 
  	@user.password = @user.password_confirmation = " "*10
  	assert_not @user.valid?
  end

  test "password should have a minimum length" do 
  	@user.password = @user.password_confirmation = "t"*7
  	assert_not @user.valid?
  end

end
