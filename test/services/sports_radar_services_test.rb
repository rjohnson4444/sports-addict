require 'test_helper'

class SportRadarServiceTest < ActiveSupport::TestCase
  attr_reader :service

  def service
    @service = SportRadarService.new
  end

  test "favorite_team_standings returns all team standings" do
    VCR.use_cassette("#favorite_team_standings") do
      standings_response = service.favorite_team_standings

      assert_equal "EASTERN CONFERENCE", standings_response[:conferences].first[:name]
      assert_equal "WESTERN CONFERENCE", standings_response[:conferences].last[:name]
      assert_equal 2, standings_response[:conferences].count

      standings_response[:conferences].each do |conference|
        assert conference[:name]
        assert conference[:alias]
        assert_equal 3, conference[:divisions].count
      end

      standings_response[:conferences].first[:divisions].each do |division|
        assert division[:name]
        assert division[:alias]
        assert_equal 5, division[:teams].count
      end
    end
  end

  test "nba_scheduled_games_for_today returns all games schedule for specific day" do
    VCR.use_cassette("#nba_scheduled_games") do
      scheduled_response = service.nba_scheduled_games_for_today

      assert_equal "2016-01-20", scheduled_response[:date]

      scheduled_response[:games].each do |game|
        assert game[:status]
        assert game[:scheduled]
        assert game[:venue]
        assert game[:broadcast]
        assert game[:home]
        assert game[:away]
      end
    end
  end
end
