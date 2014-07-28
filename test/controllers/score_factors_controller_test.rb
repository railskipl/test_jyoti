require 'test_helper'

class ScoreFactorsControllerTest < ActionController::TestCase
  setup do
    @score_factor = score_factors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:score_factors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create score_factor" do
    assert_difference('ScoreFactor.count') do
      post :create, score_factor: { description: @score_factor.description, name: @score_factor.name }
    end

    assert_redirected_to score_factor_path(assigns(:score_factor))
  end

  test "should show score_factor" do
    get :show, id: @score_factor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @score_factor
    assert_response :success
  end

  test "should update score_factor" do
    patch :update, id: @score_factor, score_factor: { description: @score_factor.description, name: @score_factor.name }
    assert_redirected_to score_factor_path(assigns(:score_factor))
  end

  test "should destroy score_factor" do
    assert_difference('ScoreFactor.count', -1) do
      delete :destroy, id: @score_factor
    end

    assert_redirected_to score_factors_path
  end
end
