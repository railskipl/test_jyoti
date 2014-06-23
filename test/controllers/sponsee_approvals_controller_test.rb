require 'test_helper'

class SponseeApprovalsControllerTest < ActionController::TestCase
  setup do
    @sponsee_approval = sponsee_approvals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sponsee_approvals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sponsee_approval" do
    assert_difference('SponseeApproval.count') do
      post :create, sponsee_approval: { approve_custom_factor: @sponsee_approval.approve_custom_factor, custom_factor: @sponsee_approval.custom_factor, your_choise_custom_factor: @sponsee_approval.your_choise_custom_factor }
    end

    assert_redirected_to sponsee_approval_path(assigns(:sponsee_approval))
  end

  test "should show sponsee_approval" do
    get :show, id: @sponsee_approval
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sponsee_approval
    assert_response :success
  end

  test "should update sponsee_approval" do
    patch :update, id: @sponsee_approval, sponsee_approval: { approve_custom_factor: @sponsee_approval.approve_custom_factor, custom_factor: @sponsee_approval.custom_factor, your_choise_custom_factor: @sponsee_approval.your_choise_custom_factor }
    assert_redirected_to sponsee_approval_path(assigns(:sponsee_approval))
  end

  test "should destroy sponsee_approval" do
    assert_difference('SponseeApproval.count', -1) do
      delete :destroy, id: @sponsee_approval
    end

    assert_redirected_to sponsee_approvals_path
  end
end
