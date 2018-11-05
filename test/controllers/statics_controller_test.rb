require 'test_helper'

class StaticsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @michael = users(:michael)
  end

  test "home page without a logged in user" do
    get root_path
    assert_select "a[href=?]", login_path, count: 2
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@michael), count: 0
    assert_select "a[href=?]", users_path, count: 0
  end

  test "home page with a logged in user" do
    get login_path
    post login_path, params:{user:{email:@michael.email}}
    assert_redirected_to @michael
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "a[href=?]", secret_path, count: 1
    assert_select "a[href=?]", users_path, count: 1
  end

end
