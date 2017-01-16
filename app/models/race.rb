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
      results = race_results.includes(:racer).where('racers.category': category[1]).sort{|x,y| x.finish_time <=> y.finish_time}.select{ |rr| rr.lap_times.length > 0 }.first(25)

      p category
      p results.count
      results.each_with_index do |rr, index|
        # podijeli bodove
        p rr
        rr.update!(points: Race.points[index])
      end
    end
  end

  def to_csv
    CSV.generate() do |csv|
      csv << ['Startni broj', 'Ime', 'Prezime', 'Klub', 'Godiste', 'Prebivaliste', 'Email', 'Mobitel', 'Vrijeme', 'Status', 'Bodovi']
      race_results.each do |race_result|
        csv << race_result.to_csv
      end
    end
  end

  def start_box_racers
    # for 10 racers per category
    # 1 box racer
    box_racers = []

    Racer.categories.each do |category|
      p category
      next if ['u16', 'zene'].include?(category[0])
      # 1 box place for 10 racers
      box_places = racers.where(category: category).count/10
      box_racers << racers.where(category: category).sort_by{|r| -r.total_points}.first(box_places)
    end

    box_racers.flatten
  end
end
