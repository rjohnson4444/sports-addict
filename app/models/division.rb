class Division < ActiveRecord::Base
  belongs_to :conference
  has_many :favorite_teams
end
