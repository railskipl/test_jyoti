require 'test_helper'

class SponseesControllerTest < ActionController::TestCase
  setup do
    @sponsee = sponsees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sponsees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sponsee" do
    assert_difference('Sponsee.count') do
      post :create, sponsee: { approve_admin_custom_factor: @sponsee.approve_admin_custom_factor, email: @sponsee.email, relationship_id: @sponsee.relationship_id, user_id: @sponsee.user_id, your_choise_custom_factor: @sponsee.your_choise_custom_factor }
    end

    assert_redirected_to sponsee_path(assigns(:sponsee))
  end

  test "should show sponsee" do
    get :show, id: @sponsee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sponsee
    assert_response :success
  end

  test "should update sponsee" do
    patch :update, id: @sponsee, sponsee: { approve_admin_custom_factor: @sponsee.approve_admin_custom_factor, email: @sponsee.email, relationship_id: @sponsee.relationship_id, user_id: @sponsee.user_id, your_choise_custom_factor: @sponsee.your_choise_custom_factor }
    assert_redirected_to sponsee_path(assigns(:sponsee))
  end

  test "should destroy sponsee" do
    assert_difference('Sponsee.count', -1) do
      delete :destroy, id: @sponsee
    end

    assert_redirected_to sponsees_path
  end
end
