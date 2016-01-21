require 'test_helper'

class UserCanLoginWithTwitterTest < ActionDispatch::IntegrationTest
  test "logged in" do
    VCR.use_cassette("login_user#user") do
      make_favorite_teams
      login_user

      find('#select').find(:xpath, 'option[2]').select_option
      click_button "Update Profile"

      assert_equal 200, page.status_code
      assert_equal "/dashboard", current_path
      assert page.has_content?("Ryan Johnson")
      assert page.has_link?("Logout")
    end
  end
end
