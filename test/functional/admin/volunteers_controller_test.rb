require 'test_helper'

class Admin::VolunteersControllerTest < ActionController::TestCase
  setup do
    @admin_volunteer = admin_volunteers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_volunteers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_volunteer" do
    assert_difference('Admin::Volunteer.count') do
      post :create, :admin_volunteer => @admin_volunteer.attributes
    end

    assert_redirected_to admin_volunteer_path(assigns(:admin_volunteer))
  end

  test "should show admin_volunteer" do
    get :show, :id => @admin_volunteer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @admin_volunteer.to_param
    assert_response :success
  end

  test "should update admin_volunteer" do
    put :update, :id => @admin_volunteer.to_param, :admin_volunteer => @admin_volunteer.attributes
    assert_redirected_to admin_volunteer_path(assigns(:admin_volunteer))
  end

  test "should destroy admin_volunteer" do
    assert_difference('Admin::Volunteer.count', -1) do
      delete :destroy, :id => @admin_volunteer.to_param
    end

    assert_redirected_to admin_volunteers_path
  end
end
