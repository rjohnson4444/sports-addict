ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'simplecov'
require 'webmock'
require 'vcr'
require 'minitest/mock'
require 'minitest/emoji'

SimpleCov.start "rails"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  VCR.configure do |config|
    config.cassette_library_dir = "test/cassettes"
    config.hook_into :webmock
  end
end

class ActionController::TestCase
  def json_response
    JSON.parse(response.body)
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = SportsAddict::Application
    stub_omniauth
  end

  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      :provider => "twitter",
      :uid => "123456",
      :info => {
        :name => "Ryan Johnson",
        :image => "http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png",
      },
      :credentials => {
        :token => ENV["OAUTH_TOKEN"],
        :secret => ENV["OAUTH_SECRET"]
        }})
  end

  def login_user
    visit root_path
    click_link "Twitter"
  end

  def teardown
    reset_session!
  end
end

class Minitest::Spec
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

def create_conference
  Conference.create!(id: 2,
                     name: "WESTERN CONFERENCE")

  Conference.create!(id: 1,
                     name: "EASTERN CONFERENCE")

end

def create_division
  create_conference

  Division.create!(id: 5,
                   name: "Northwest",
                   conference_id: 2
                   )

 Division.create!(id: 1,
                  name: "Atlantic",
                  conference_id: 1
                  )

end

def make_favorite_teams
  create_division

  FavoriteTeam.create!(name: "Thunder",
                       city: "Oklahoma City",
                       division_id: 5,
                       image: "thunder.gif"
                       )

  FavoriteTeam.create!(name: "Jazz",
                       city: "Utah",
                       division_id: 5,
                       image: "jazz.gif"
                       )

  FavoriteTeam.create!(name: "Trail Blazers",
                       city: "Portland",
                       division_id: 5,
                       image: "blazers.gif"
                       )

  FavoriteTeam.create!(name: "Nuggets",
                       city: "Denver",
                       division_id: 5,
                       image: "nuggets.gif"
                       )

  FavoriteTeam.create!(name: "Timberwolves",
                       city: "Minnesota",
                       division_id: 5,
                       image: "timberwolves.gif"
                       )

 FavoriteTeam.create!(name: "Knicks",
                      city: "New York",
                      division_id: 1,
                      image: "knicks.gif"
                      )

  FavoriteTeam.create!(name: "76ers",
                       city: "Philadelphia",
                       division_id: 1,
                       image: "76ers.gif"
                       )

end
