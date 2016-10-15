class Race < ApplicationRecord
  has_many :race_results
  has_many :racers, through: :race_results

  def self.points
    [
      250, 200, 160, 150, 140, 130, 120,
      110, 100, 90, 80, 75, 70, 65, 60,
      55, 50, 45, 40, 35, 30, 25, 20, 15, 10
    ]
  end

  def assign_points
    # za svaku kategoriju
    Racer.categories.each do |category|
      # nadi top 25 rezultata
      race_results.includes(:racer).where({'racers.category': category })
        .sort{|x,y| x.finish_time <=> y.finish_time}
        .first(25)
        .select{ |rr| rr.lap_times.length > 0 }
        .each_with_index do |rr, index|
        # podijeli bodove
        rr.update!(points: Race.points[index])
      end
    end
  end
end
