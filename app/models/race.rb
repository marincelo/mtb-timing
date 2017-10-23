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
      results = race_results.includes(:racer).where(status: 3).where('racers.category': category[1]).sort{|x,y| x.finish_time <=> y.finish_time}.select{ |rr| rr.lap_times.length > 0 }.first(25)

      p category
      p results.count
      results.each_with_index do |rr, index|
        # podijeli bodove
        p rr
        rr.update!(points: Race.points[index])
      end
    end
  end

  def assign_clubs_points
    clubs = racers.includes(:club).collect(&:club).uniq
    clubs = clubs.sort_by{ |club| club.points_in_race self }
    points = 1

    clubs.each do |club|
      club.update!(points: club.points + points)
      points += 1
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
      next if ['u16', 'zene'].include?(category[0])
      category_racers = racers.where(category: category)
      # 2 box places for 1-20 racers
      if category_racers.count <= 20
        box_places = 2
      # 3 box places for 21-30 etc
      else
        box_places = category_racers.count/10 + 1
      end
      box_racers << category_racers.sort_by{|r| -r.total_points}.first(box_places)
    end

    box_racers.flatten
  end
end
