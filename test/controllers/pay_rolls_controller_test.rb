require 'test_helper'

class PayRollsControllerTest < ActionController::TestCase
  setup do
    @pay_roll = pay_rolls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pay_rolls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pay_roll" do
    assert_difference('PayRoll.count') do
      post :create, pay_roll: { end_date: @pay_roll.end_date, start_date: @pay_roll.start_date }
    end

    assert_redirected_to pay_roll_path(assigns(:pay_roll))
  end

  test "should show pay_roll" do
    get :show, id: @pay_roll
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pay_roll
    assert_response :success
  end

  test "should update pay_roll" do
    patch :update, id: @pay_roll, pay_roll: { end_date: @pay_roll.end_date, start_date: @pay_roll.start_date }
    assert_redirected_to pay_roll_path(assigns(:pay_roll))
  end

  test "should destroy pay_roll" do
    assert_difference('PayRoll.count', -1) do
      delete :destroy, id: @pay_roll
    end

    assert_redirected_to pay_rolls_path
  end
end
