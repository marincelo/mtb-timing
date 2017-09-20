class RaceResult < ApplicationRecord
  belongs_to :racer
  belongs_to :race
  attr_accessor :racer_start_number

  validate :disallow_duplicates

  def disallow_duplicates
    return if self.id
    errors.add(:racer, 'prijava vec postoji!') if RaceResult.exists?(racer: self.racer, race: self.race)
  end

  def pretty_status
    case status
    when 1
      'Prijavljen'
    when 2
      'Na startu'
    when 3
      'Zavrsio'
    when 4
      'DNF'
    when 5
      'DSQ'
    when 6
      'DNS'
    else
      'Nepoznat'
    end
  end

  def finish_time
    if race && lap_times.length > 0
      seconds = Time.at(lap_times.last.to_f) - race.started_at
      Time.at(seconds).utc.strftime("%H:%M:%S.%L")
    else
      '- -'
    end
  end

  def to_csv
    # ['Startni broj', 'Ime', 'Prezime', 'Klub',
    # 'Godiste', 'Prebivaliste', 'Email', 'Mobitel', 'Vrijeme', 'Status', 'Bodovi']
    return [racer.start_number, racer.first_name, racer.last_name, racer.club.try(:name),
      racer.year_of_birth, racer.town, racer.email, racer.phone_number, finish_time, status, points]
  end
end
