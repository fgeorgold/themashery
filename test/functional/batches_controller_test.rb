require 'test_helper'

class BatchesControllerTest < ActionController::TestCase
  setup :activate_authlogic
  
  def setup
    UserSession.create(users(:joe))
  end
  
  test "should require a user to log in" do
    UserSession.find.destroy
    get :index
    assert_response :redirect
  end  
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:batches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create batch" do
    assert_difference('Batch.count') do
      post :create, :batch => batches(:one).attributes
    end

    assert_redirected_to batch_path(assigns(:batch))
  end

  test "should show batch" do
    get :show, :id => batches(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => batches(:one).to_param
    assert_response :success
  end

  test "should update batch" do
    put :update, :id => batches(:one).to_param, :batch => batches(:one).attributes
    assert_redirected_to batch_path(assigns(:batch))
  end

  test "should destroy batch" do
    assert_difference('Batch.count', -1) do
      delete :destroy, :id => batches(:one).to_param
    end

    assert_redirected_to batches_path
  end
end
