require 'test_helper'

class SponsercfsControllerTest < ActionController::TestCase
  setup do
    @sponsercf = sponsercfs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sponsercfs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sponsercf" do
    assert_difference('Sponsercf.count') do
      post :create, sponsercf: { custom_factor_string: @sponsercf.custom_factor_string, email: @sponsercf.email, name: @sponsercf.name, sponser_id: @sponsercf.sponser_id, user_id: @sponsercf.user_id }
    end

    assert_redirected_to sponsercf_path(assigns(:sponsercf))
  end

  test "should show sponsercf" do
    get :show, id: @sponsercf
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sponsercf
    assert_response :success
  end

  test "should update sponsercf" do
    patch :update, id: @sponsercf, sponsercf: { custom_factor_string: @sponsercf.custom_factor_string, email: @sponsercf.email, name: @sponsercf.name, sponser_id: @sponsercf.sponser_id, user_id: @sponsercf.user_id }
    assert_redirected_to sponsercf_path(assigns(:sponsercf))
  end

  test "should destroy sponsercf" do
    assert_difference('Sponsercf.count', -1) do
      delete :destroy, id: @sponsercf
    end

    assert_redirected_to sponsercfs_path
  end
end
