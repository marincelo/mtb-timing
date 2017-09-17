class Racer < ApplicationRecord
  belongs_to :user, dependent: :delete
  belongs_to :club
  has_many :race_results, dependent: :destroy
  has_many :races, through: :race_results

  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true

  enum category: [:zene, :u16, :'16-20', :'20-30', :'30-40', :'40-50', :'50+']

  default_scope { order(start_number: :asc) }

  before_create :set_start_number
  before_update :check_and_set_start_number

  def get_start_number_and_category
    # female racers
    data = {}
    if gender == 1
      racer = Racer.unscoped.where(gender: 1).order(start_number: :desc).first
      data[:start_number] = racer.present? ? racer.start_number + 1 : 600
      data[:category] = Racer.categories[:zene]
      if data[:start_number] == 700
        data[:start_number] = 6600
      end
    # male racers
    elsif gender == 2
      if year_of_birth > 2001
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth > 2001').order(start_number: :desc).first
        data[:start_number] = racer.present? ? racer.start_number + 1 : 1
        data[:category] = Racer.categories[:u16]
      elsif (1998..2001).include? year_of_birth
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth <= 2001 AND year_of_birth >= 1998').order(start_number: :desc).first
        data[:start_number] = racer.present? ? racer.start_number + 1 : 100
        data[:category] = Racer.categories[:'16-20']
        # alternative numbers
        if data[:start_number] == 200
          data[:start_number] = 1100
        end
      elsif (1988..1997).include? year_of_birth
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth < 1998 AND year_of_birth >= 1988').order(start_number: :desc).first
        data[:start_number] = racer.present? ? racer.start_number + 1 : 200
        data[:category] = Racer.categories[:'20-30']
        # alternative numbers
        if data[:start_number] == 300
          data[:start_number] = 2200
        end
      elsif (1978..1987).include? year_of_birth
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth < 1988 AND year_of_birth >= 1978').order(start_number: :desc).first
        data[:start_number] = racer.present? ? racer.start_number + 1 : 300
        data[:category] = Racer.categories[:'30-40']
        # alternative numbers
        if data[:start_number] == 400
          data[:start_number] = 3300
        end
      elsif (1968..1977).include? year_of_birth
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth < 1978 AND year_of_birth >= 1968').order(start_number: :desc).first
        data[:start_number] = racer.present? ? racer.start_number + 1 : 400
        data[:category] = Racer.categories[:'40-50']
        # alternative numbers
        if data[:start_number] == 500
          data[:start_number] = 4400
        end
      elsif year_of_birth < 1968
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth < 1968').order(start_number: :desc).first
        data[:start_number] = racer.present? ? racer.start_number + 1 : 500
        data[:category] = Racer.categories[:'50+']
        if data[:start_number] == 600
          data[:start_number] = 5500
        end
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

  def full_name
    "#{first_name} #{last_name}"
  end

  def total_points
    race_results.sum{|rr| rr.points || 0}
  end
end
