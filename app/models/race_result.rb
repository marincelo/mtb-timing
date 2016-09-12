class RaceResult < ApplicationRecord
  belongs_to :racer
  belongs_to :race
  attr_accessor :racer_start_number

  validate :disallow_duplicates

  def disallow_duplicates
    errors.add(:racer, 'prijava vec postoji!') if RaceResult.exists?(racer: self.racer, race: self.race)
  end
end
