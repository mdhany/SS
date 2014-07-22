require 'test_helper'

class Admin::CapacitiesControllerTest < ActionController::TestCase
  setup do
    @admin_capacity = admin_capacities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_capacities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_capacity" do
    assert_difference('Admin::Capacity.count') do
      post :create, admin_capacity: {  }
    end

    assert_redirected_to admin_capacity_path(assigns(:admin_capacity))
  end

  test "should show admin_capacity" do
    get :show, id: @admin_capacity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_capacity
    assert_response :success
  end

  test "should update admin_capacity" do
    patch :update, id: @admin_capacity, admin_capacity: {  }
    assert_redirected_to admin_capacity_path(assigns(:admin_capacity))
  end

  test "should destroy admin_capacity" do
    assert_difference('Admin::Capacity.count', -1) do
      delete :destroy, id: @admin_capacity
    end

    assert_redirected_to admin_capacities_path
  end
end
