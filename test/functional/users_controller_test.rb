require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  setup :activate_authlogic
  
  def setup
    @fields = {:email => "test@test.com",
               :password => "password",
               :password_confirmation => "password"}
  end
  
  test "new returns a new user form when logged out" do
    get :new
    assert_response :success
  end
  
  test "new redirects when logged in" do
    UserSession.create(users(:joe))
    get :new
    assert_response :redirect
  end
  
  test "create fails when no email" do
    @fields.delete_if {|key,value| key == :email}
    assert_no_difference('User.count') do
      post :create, :user => @fields
    end
  end
  
  test "create fails when no password" do
    @fields.delete_if {|key,value| key == :password}
    assert_no_difference('User.count') do
      post :create, :user => @fields
    end
  end
  
  test "create fails when no confirmation" do
    @fields.delete_if {|key,value| key == :password_confirmation}
    assert_no_difference('User.count') do
      post :create, :user => @fields
    end
  end
  
  test "create fails when confirmation mismatches" do
    @fields[:password] = "password"
    @fields[:password_confirmation] = "notpassword"
    assert_no_difference('User.count') do
      post :create, :user => @fields
    end
  end
  
  test "create succeeds when fields are valid" do
    assert_difference('User.count') do
      post :create, :user => @fields
    end
    assert_redirected_to account_path
  end
  
  test "show displays the account page" do
    UserSession.create(users(:joe))
    get :show
    assert_response :success
  end
  
  test "show redirects when not logged in" do
    get :show
    assert_response :redirect
  end
  
  test "edit shows the acount editing page" do
    UserSession.create(users(:joe))
    get :edit
    assert_response :success
  end
  
  test "edit redirects when not logged in" do
    get :edit
    assert_response :redirect
  end
  
  test "update fails when no password" do
    UserSession.create(users(:joe))
    @fields = users(:joe).attributes
    @fields.delete_if {|key,value| key == :password}
    assert_no_difference('User.count') do
      post :update, :user => @fields
    end
  end
  
  test "update fails when no confirmation" do
    UserSession.create(users(:joe))
    @fields = users(:joe).attributes
    @fields.delete_if {|key,value| key == :password_confirmation}
    assert_no_difference('User.count') do
      post :update, :user => @fields
    end
  end
  
  test "update fails when confirmation mismatches" do
    UserSession.create(users(:joe))
    @fields = users(:joe).attributes
    @fields[:password] = "password"
    @fields[:password_confirmation] = "notpassword"
    assert_no_difference('User.count') do
      post :update, :user => @fields
    end
  end
  
  test "update fails when not logged in" do
    @fields = users(:joe).attributes
    post :update, :user => @fields
    assert_redirected_to login_path
  end
  
  test "update succeeds when fields are valid" do
    UserSession.create(users(:joe))
    @fields = users(:joe).attributes
    post :update, :user => @fields
    assert_redirected_to account_path
  end
end
