require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @michael = users(:michael)
    @david = User.new(first_name: "David",last_name: "Gerard",email: "david@fefe.fe")
  end

  test "should be valid" do
    assert @david.valid?
  end

  test "first_name should be present" do
    @david.first_name = "     "
      assert_not @david.valid?
  end

  test "email should be unique" do
    @david.email = @michael.email
      assert_not @david.valid?
  end

end
