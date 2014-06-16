require 'test_helper'

class AdviceContactsControllerTest < ActionController::TestCase
  setup do
    @advice_contact = advice_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:advice_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create advice_contact" do
    assert_difference('AdviceContact.count') do
      post :create, advice_contact: { criticism: @advice_contact.criticism, email: @advice_contact.email, helpful_tips: @advice_contact.helpful_tips, praise: @advice_contact.praise }
    end

    assert_redirected_to advice_contact_path(assigns(:advice_contact))
  end

  test "should show advice_contact" do
    get :show, id: @advice_contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @advice_contact
    assert_response :success
  end

  test "should update advice_contact" do
    patch :update, id: @advice_contact, advice_contact: { criticism: @advice_contact.criticism, email: @advice_contact.email, helpful_tips: @advice_contact.helpful_tips, praise: @advice_contact.praise }
    assert_redirected_to advice_contact_path(assigns(:advice_contact))
  end

  test "should destroy advice_contact" do
    assert_difference('AdviceContact.count', -1) do
      delete :destroy, id: @advice_contact
    end

    assert_redirected_to advice_contacts_path
  end
end
