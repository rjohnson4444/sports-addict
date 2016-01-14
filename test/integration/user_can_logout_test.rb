require 'test_helper'

class UserCanLogoutTest < ActionDispatch::IntegrationTest
  test "logged out" do
    VCR.use_cassette("logout_user#user") do
      make_favorite_teams
      login_user
      click_link "Logout"

      assert_equal 200, page.status_code
      assert_equal root_path, current_path
      assert page.has_link?("Twitter")
    end
  end
end
