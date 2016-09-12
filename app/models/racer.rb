class Racer < ApplicationRecord
  belongs_to :user
  belongs_to :club
  has_many :race_results
  has_many :races, through: :race_results

  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true

  enum category: [:zene, :u16, :u20, :u30, :u40, :u50, :'50+']

  default_scope { order(start_number: :asc) }

  before_create :set_start_number
  before_update :check_and_set_start_number

  def get_start_number_and_category
    # female racers
    data = {}
    if gender == 1
      racer = Racer.unscoped.where(gender: 1).last
      data[:start_number] = racer.present? ? racer.start_number + 1 : 600
      data[:category] = Racer.categories[:zene]
    # male racers
    elsif gender == 2
      if year_of_birth >= 2000
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth >= 2000').last
        data[:start_number] = racer.present? ? racer.start_number + 1 : 1
        data[:category] = Racer.categories[:u16]
      elsif (1997..1999).include? year_of_birth
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth < 2000 AND year_of_birth >= 1997').last
        data[:start_number] = racer.present? ? racer.start_number + 1 : 100
        data[:category] = Racer.categories[:u20]
      elsif (1987..1996).include? year_of_birth
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth < 1997 AND year_of_birth >= 1987').last
        data[:start_number] = racer.present? ? racer.start_number + 1 : 200
        data[:category] = Racer.categories[:u30]
      elsif (1977..1986).include? year_of_birth
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth < 1987 AND year_of_birth >= 1977').last
        data[:start_number] = racer.present? ? racer.start_number + 1 : 300
        data[:category] = Racer.categories[:u40]
      elsif (1967..1976).include? year_of_birth
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth < 1977 AND year_of_birth >= 1967').last
        data[:start_number] = racer.present? ? racer.start_number + 1 : 400
        data[:category] = Racer.categories[:u50]
      elsif year_of_birth < 1967
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth < 1977 AND year_of_birth >= 1967').last
        data[:start_number] = racer.present? ? racer.start_number + 1 : 500
        data[:category] = Racer.categories[:'50+']
      else
        fail 'Unknown category'
      end
    end
    data
  end

  def set_start_number
    data = get_start_number_and_category
    self.start_number = data[:start_number]
    self.category = data[:category]
  end

  def check_and_set_start_number
    set_start_number if year_of_birth_changed?
  end
end
