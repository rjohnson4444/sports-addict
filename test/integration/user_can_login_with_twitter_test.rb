require 'test_helper'

class UserCanLoginWithTwitterTest < ActionDispatch::IntegrationTest
  test "logged in" do
    login_user

    assert_equal 200, page.status_code
    assert_equal "/dashboard", current_path
    assert page.has_content?("Ryan Johnson")
    assert page.has_link?("Logout")
  end
end
