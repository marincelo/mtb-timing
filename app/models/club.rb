class Club < ApplicationRecord
  belongs_to :user, optional: true
  has_many :racers

  def points_in_race (race)
    RaceResult.includes(:racer)
    .where(racer: racers, race: race)
    .sum(:points)
  end

  def racers_count
    racers.count
  end
end
