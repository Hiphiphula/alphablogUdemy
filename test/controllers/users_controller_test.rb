require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "thisistatest", email: "idk@gmail.com", password: "password")
    @admin_user = User.create(username: "admin123", email: "admin123@gmail.com", password: "password", admin: true)
  end

  test "should get index" do
    get users_path
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    # post users_url, params: { user: { username: "test1", email: "testsa1@gmail.com", password: "password" } }
    # if @controller.instance_variable_get(:@user).errors.any?
    #   puts @controller.instance_variable_get(:@user).errors.full_messages
    # end
    assert_difference("User.count", 1) do
      post users_url, params: { user: { username: "test1", email: "tests1@gmail.com", password: "password" } }
    end

    assert_redirected_to home_path
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    sign_in_as(@user)
    patch user_url(@user), params: { user: { username: @user.username } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user as an admin" do
    sign_in_as(@admin_user)
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to articles_path
  end
end
