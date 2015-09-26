require 'test_helper'

class PaymentRecordPaySchemesControllerTest < ActionController::TestCase
  setup do
    @payment_record_pay_scheme = payment_record_pay_schemes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payment_record_pay_schemes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment_record_pay_scheme" do
    assert_difference('PaymentRecordPayScheme.count') do
      post :create, payment_record_pay_scheme: {  }
    end

    assert_redirected_to payment_record_pay_scheme_path(assigns(:payment_record_pay_scheme))
  end

  test "should show payment_record_pay_scheme" do
    get :show, id: @payment_record_pay_scheme
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payment_record_pay_scheme
    assert_response :success
  end

  test "should update payment_record_pay_scheme" do
    patch :update, id: @payment_record_pay_scheme, payment_record_pay_scheme: {  }
    assert_redirected_to payment_record_pay_scheme_path(assigns(:payment_record_pay_scheme))
  end

  test "should destroy payment_record_pay_scheme" do
    assert_difference('PaymentRecordPayScheme.count', -1) do
      delete :destroy, id: @payment_record_pay_scheme
    end

    assert_redirected_to payment_record_pay_schemes_path
  end
end
