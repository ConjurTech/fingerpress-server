require 'test_helper'

class PaySchemesControllerTest < ActionController::TestCase
  setup do
    @pay_scheme = pay_schemes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pay_schemes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pay_scheme" do
    assert_difference('PayScheme.count') do
      post :create, pay_scheme: { pay: @pay_scheme.pay, pay_ot: @pay_scheme.pay_ot, pay_public_holiday: @pay_scheme.pay_public_holiday, pay_type_id: @pay_scheme.pay_type_id }
    end

    assert_redirected_to pay_scheme_path(assigns(:pay_scheme))
  end

  test "should show pay_scheme" do
    get :show, id: @pay_scheme
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pay_scheme
    assert_response :success
  end

  test "should update pay_scheme" do
    patch :update, id: @pay_scheme, pay_scheme: { pay: @pay_scheme.pay, pay_ot: @pay_scheme.pay_ot, pay_public_holiday: @pay_scheme.pay_public_holiday, pay_type_id: @pay_scheme.pay_type_id }
    assert_redirected_to pay_scheme_path(assigns(:pay_scheme))
  end

  test "should destroy pay_scheme" do
    assert_difference('PayScheme.count', -1) do
      delete :destroy, id: @pay_scheme
    end

    assert_redirected_to pay_schemes_path
  end
end
