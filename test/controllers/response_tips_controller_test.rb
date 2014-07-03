require 'test_helper'

class ResponseTipsControllerTest < ActionController::TestCase
  setup do
    @response_tip = response_tips(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:response_tips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create response_tip" do
    assert_difference('ResponseTip.count') do
      post :create, response_tip: { response_for_tip: @response_tip.response_for_tip, tag_tip: @response_tip.tag_tip, tip_id: @response_tip.tip_id, user_id: @response_tip.user_id }
    end

    assert_redirected_to response_tip_path(assigns(:response_tip))
  end

  test "should show response_tip" do
    get :show, id: @response_tip
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @response_tip
    assert_response :success
  end

  test "should update response_tip" do
    patch :update, id: @response_tip, response_tip: { response_for_tip: @response_tip.response_for_tip, tag_tip: @response_tip.tag_tip, tip_id: @response_tip.tip_id, user_id: @response_tip.user_id }
    assert_redirected_to response_tip_path(assigns(:response_tip))
  end

  test "should destroy response_tip" do
    assert_difference('ResponseTip.count', -1) do
      delete :destroy, id: @response_tip
    end

    assert_redirected_to response_tips_path
  end
end
