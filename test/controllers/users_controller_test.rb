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

  test "no sign in with invalid information" do
    get new_user_path
    assert_difference 'User.count', 0 do
      post users_path, params:{user:{first_name:"Pince", last_name: "Moi", email:@michael.email}}
    end
  end

  test "access to user/show with a logged in user" do
    get login_path
    post login_path, params:{user:{ email:@michael.email}}
    assert is_logged_in?
    get user_path(id:@michael.id)
    assert_select "h6", {:count=>1, :text=> "First_name : #{@michael.first_name}"}
    assert_select "h6", {:count=>1, :text=> "Last_name : #{@michael.first_name}"}
    assert_select "p", {:count=>1, :text=> "Email : #{@michael.email}"}
  end

  test "no access to user/show without a logged in user" do
    get user_path(id:@michael.id)
    assert_template 'users/new'
    assert_not flash.empty?
  end

  test "access to user/show of an other user" do
    get login_path
    post login_path, params:{user:{ email:@michael.email}}
    assert is_logged_in?
    get user_path(id:@michael.id+1) #try to access an other user
    assert_template 'users/show'
    assert_not flash.empty?
  end

end
