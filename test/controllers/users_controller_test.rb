require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @michael = users(:michael)
  end


  test "sign in with valid information" do
    get new_user_path
    assert_difference 'User.count', 1 do
      post users_path, params:{user:{first_name:"Pince", last_name: "Moi", email:"pince.moi@thp.com"}}
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

  test "sign in with invalid information" do
    get new_user_path
    assert_difference 'User.count', 0 do
      post users_path, params:{user:{first_name:"Pince", last_name: "Moi", email:@michael.email}}
    end
  end

end
