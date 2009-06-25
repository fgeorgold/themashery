require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  setup :activate_authlogic
  
  def setup
    @fields = {:title => "sometitle", :ingredients => "someingredients", :directions => "somedirections"}
    UserSession.create(users(:joe))
  end
  
  test "should require user to log in" do
    UserSession.find.destroy
    get :index
    assert_response :redirect
  end
    
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipe" do
    assert_difference('Recipe.count') do
      post :create, :recipe => @fields
    end

    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should show recipe" do
    get :show, :id => recipes(:lager).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => recipes(:lager).to_param
    assert_response :success
  end

  test "should update recipe" do
    put :update, :id => recipes(:lager).to_param, :recipe => recipes(:lager).attributes
    assert_redirected_to recipe_path(assigns(:recipe))
  end
  
  test "should not update recipe owned by another user" do
    UserSession.find.destroy
    UserSession.create(users(:bob))
    put :update, :id => recipes(:lager).to_param, :recipe => recipes(:lager).attributes
    assert_redirected_to account_path
  end
  
  test "should always allow update by admin" do
    UserSession.find.destroy
    UserSession.create(users(:admin))
    put :update, :id => recipes(:lager).to_param, :recipe => recipes(:lager).attributes
    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should destroy recipe" do
    assert_difference('Recipe.count', -1) do
      delete :destroy, :id => recipes(:lager).to_param
    end

    assert_redirected_to recipes_path
  end
  
  test "should not destroy recipe owned by another user" do
    UserSession.find.destroy
    UserSession.create(users(:bob))
    assert_no_difference('Recipe.count') do
      delete :destroy, :id => recipes(:lager).to_param
    end
    
    assert_redirected_to account_path
  end
  
  test "should always destroy when called by admin" do
    UserSession.find.destroy
    UserSession.create(users(:admin))
    assert_difference('Recipe.count', -1) do
      delete :destroy, :id => recipes(:lager).to_param
    end
    
    assert_redirected_to recipes_path
  end
end
