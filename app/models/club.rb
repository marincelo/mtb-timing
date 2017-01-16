class Club < ApplicationRecord
  belongs_to :user
  has_many :racers

  def points
    # each race
    # top racer from category
    # points
    points = 0
    Race.all.each do |race|
      processed_categories = []
      race_results = RaceResult.includes(:racer).where(racer: racers, race: race).order(points: :desc)
      race_results.each do |rr|
        unless rr.points.nil? || processed_categories.include?(rr.racer.category)
          points += rr.points
          processed_categories << rr.racer.category
        end
      end
    end
    points
  end
end
