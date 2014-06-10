require 'test_helper'

class PasteUsersControllerTest < ActionController::TestCase
  setup do
    @paste_user = paste_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paste_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paste_user" do
    assert_difference('PasteUser.count') do
      post :create, paste_user: { email: @paste_user.email, name: @paste_user.name, user_id: @paste_user.user_id }
    end

    assert_redirected_to paste_user_path(assigns(:paste_user))
  end

  test "should show paste_user" do
    get :show, id: @paste_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @paste_user
    assert_response :success
  end

  test "should update paste_user" do
    patch :update, id: @paste_user, paste_user: { email: @paste_user.email, name: @paste_user.name, user_id: @paste_user.user_id }
    assert_redirected_to paste_user_path(assigns(:paste_user))
  end

  test "should destroy paste_user" do
    assert_difference('PasteUser.count', -1) do
      delete :destroy, id: @paste_user
    end

    assert_redirected_to paste_users_path
  end
end
