class Racer < ApplicationRecord
  belongs_to :user
  belongs_to :club
  has_many :race_results
  has_many :races, through: :race_results

  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true

  before_save :set_start_number

  def get_start_number
    # female racers
    if gender == 1
      racer = Racer.where(gender: 1).last
      racer.present? ? racer.start_number + 1 : 600
    # male racers
    elsif gender == 2
      if year_of_birth >= 2000
        racer = Racer.where('gender = 2 AND year_of_birth >= 2000').last
        racer.present? ? racer.start_number + 1 : 1
      elsif (1997..1999).include? year_of_birth
        racer = Racer.where('gender = 2 AND year_of_birth < 2000 AND year_of_birth >= 1997').last
        racer.present? ? racer.start_number + 1 : 100
      elsif (1987..1996).include? year_of_birth
        racer = Racer.where('gender = 2 AND year_of_birth < 1997 AND year_of_birth >= 1987').last
        racer.present? ? racer.start_number + 1 : 200
      elsif (1977..1986).include? year_of_birth
        racer = Racer.where('gender = 2 AND year_of_birth < 1987 AND year_of_birth >= 1977').last
        racer.present? ? racer.start_number + 1 : 300
      elsif (1967..1976).include? year_of_birth
        racer = Racer.where('gender = 2 AND year_of_birth < 1977 AND year_of_birth >= 1967').last
        racer.present? ? racer.start_number + 1 : 400
      elsif year_of_birth < 1967
        racer = Racer.where('gender = 2 AND year_of_birth < 1977 AND year_of_birth >= 1967').last
        racer.present? ? racer.start_number + 1 : 500
      else
        fail 'Unknown category'
      end
    end
  end

  def set_start_number
    self.start_number = get_start_number
  end
end
