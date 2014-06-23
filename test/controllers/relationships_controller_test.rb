require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase
  setup do
    @relationship = relationships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:relationships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create relationship" do
    assert_difference('Relationship.count') do
      post :create, relationship: { email: @relationship.email, how_well_you_know_the_person: @relationship.how_well_you_know_the_person, influence_on_your: @relationship.influence_on_your, know_how_for_long_month: @relationship.know_how_for_long_month, know_how_for_long_year: @relationship.know_how_for_long_year, user_id: @relationship.user_id, your_influence: @relationship.your_influence }
    end

    assert_redirected_to relationship_path(assigns(:relationship))
  end

  test "should show relationship" do
    get :show, id: @relationship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @relationship
    assert_response :success
  end

  test "should update relationship" do
    patch :update, id: @relationship, relationship: { email: @relationship.email, how_well_you_know_the_person: @relationship.how_well_you_know_the_person, influence_on_your: @relationship.influence_on_your, know_how_for_long_month: @relationship.know_how_for_long_month, know_how_for_long_year: @relationship.know_how_for_long_year, user_id: @relationship.user_id, your_influence: @relationship.your_influence }
    assert_redirected_to relationship_path(assigns(:relationship))
  end

  test "should destroy relationship" do
    assert_difference('Relationship.count', -1) do
      delete :destroy, id: @relationship
    end

    assert_redirected_to relationships_path
  end
end
