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
    if status == 1
      'Prijavljen'
    elsif status == 2
      'Na startu'
    elsif status == 3
      'Zavrsio'
    else
      'Nepoznat'
    end
  end
end
