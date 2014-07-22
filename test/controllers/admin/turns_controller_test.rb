require 'test_helper'

class Admin::TurnsControllerTest < ActionController::TestCase
  setup do
    @admin_turn = admin_turns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_turns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_turn" do
    assert_difference('Admin::Turn.count') do
      post :create, admin_turn: {  }
    end

    assert_redirected_to admin_turn_path(assigns(:admin_turn))
  end

  test "should show admin_turn" do
    get :show, id: @admin_turn
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_turn
    assert_response :success
  end

  test "should update admin_turn" do
    patch :update, id: @admin_turn, admin_turn: {  }
    assert_redirected_to admin_turn_path(assigns(:admin_turn))
  end

  test "should destroy admin_turn" do
    assert_difference('Admin::Turn.count', -1) do
      delete :destroy, id: @admin_turn
    end

    assert_redirected_to admin_turns_path
  end
end
