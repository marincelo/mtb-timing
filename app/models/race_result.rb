class RaceResult < ApplicationRecord
  belongs_to :racer
  belongs_to :race
  attr_accessor :racer_start_number
end
