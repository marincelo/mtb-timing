class Racer < ApplicationRecord
  belongs_to :user
  belongs_to :club
  has_many :race_results, dependent: :destroy
  has_many :races, through: :race_results

  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true

  enum category: [:zene, :u16, :'16-20', :'20-30', :'30-40', :'40-50', :'50+']

  default_scope { order(start_number: :asc) }

  before_create :set_start_number
  before_update :check_and_set_start_number

  after_destroy :destroy_user

  def get_start_number_and_category
    # female racers
    data = {}
    if gender == 1
      racer = Racer.unscoped.where(gender: 1).order(start_number: :desc).first
      data[:start_number] = racer.present? ? racer.start_number + 1 : 600
      data[:category] = Racer.categories[:zene]
      if data[:start_number] == 700
        data[:start_number] = 6000
      end
    # male racers
    elsif gender == 2
      if year_of_birth > 2000
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth > 2000').order(start_number: :desc).first
        data[:start_number] = racer.present? ? racer.start_number + 1 : 1
        data[:category] = Racer.categories[:u16]
      elsif (1997..1999).include? year_of_birth
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth <= 2000 AND year_of_birth >= 1997').order(start_number: :desc).first
        data[:start_number] = racer.present? ? racer.start_number + 1 : 100
        data[:category] = Racer.categories[:'17-20']
        # alternative numbers
        if data[:start_number] == 200
          data[:start_number] = 1000
        end
      elsif (1987..1996).include? year_of_birth
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth < 1997 AND year_of_birth >= 1987').order(start_number: :desc).first
        data[:start_number] = racer.present? ? racer.start_number + 1 : 200
        data[:category] = Racer.categories[:'20-30']
        # alternative numbers
        if data[:start_number] == 300
          data[:start_number] = 2000
        end
      elsif (1977..1986).include? year_of_birth
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth < 1987 AND year_of_birth >= 1977').order(start_number: :desc).first
        data[:start_number] = racer.present? ? racer.start_number + 1 : 300
        data[:category] = Racer.categories[:'30-40']
        # alternative numbers
        if data[:start_number] == 400
          data[:start_number] = 3000
        end
      elsif (1967..1976).include? year_of_birth
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth < 1977 AND year_of_birth >= 1967').order(start_number: :desc).first
        data[:start_number] = racer.present? ? racer.start_number + 1 : 400
        data[:category] = Racer.categories[:'40-50']
        # alternative numbers
        if data[:start_number] == 500
          data[:start_number] = 4000
        end
      elsif year_of_birth < 1967
        racer = Racer.unscoped.where('gender = 2 AND year_of_birth < 1967').order(start_number: :desc).first
        data[:start_number] = racer.present? ? racer.start_number + 1 : 500
        data[:category] = Racer.categories[:'50+']
        if data[:start_number] == 600
          data[:start_number] = 5000
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

  def destroy_user
    self.user.destroy!
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
