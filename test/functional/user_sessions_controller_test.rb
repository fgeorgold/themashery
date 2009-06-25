require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "new should show registration page" do
    get :new
    assert_response :success
  end
  
  test "create should fail with no email" do
    post :create, :user_session => {:password => "password"}
    assert UserSession.find.nil?
  end
  
  test "create should succeed with valid email and password" do
    post :create, :user_session => {:email => users(:joe).email, :password => "password"}
    assert !UserSession.find.nil?
    assert_redirected_to account_path
  end
  
  test "destroy should log the user out" do
    assert UserSession.create(users(:joe))
    delete :destroy
    assert UserSession.find.nil?
  end
end
