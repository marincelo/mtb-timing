class Race < ApplicationRecord
  has_many :race_results
  has_many :racers, through: :race_results
end
