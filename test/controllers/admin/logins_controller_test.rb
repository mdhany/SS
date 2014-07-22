require 'test_helper'

class Admin::LoginsControllerTest < ActionController::TestCase
  setup do
    @admin_login = admin_logins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_logins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_login" do
    assert_difference('Admin::Login.count') do
      post :create, admin_login: {  }
    end

    assert_redirected_to admin_login_path(assigns(:admin_login))
  end

  test "should show admin_login" do
    get :show, id: @admin_login
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_login
    assert_response :success
  end

  test "should update admin_login" do
    patch :update, id: @admin_login, admin_login: {  }
    assert_redirected_to admin_login_path(assigns(:admin_login))
  end

  test "should destroy admin_login" do
    assert_difference('Admin::Login.count', -1) do
      delete :destroy, id: @admin_login
    end

    assert_redirected_to admin_logins_path
  end
end
