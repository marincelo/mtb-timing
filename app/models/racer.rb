class Racer < ApplicationRecord
  belongs_to :user, dependent: :delete, optional: true
  belongs_to :club
  has_many :race_results, dependent: :destroy
  has_many :races, through: :race_results
  has_one :start_number, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true

  enum category: [:zene, :u16, :'16-20', :'20-30', :'30-40', :'40-50', :'50+']

  before_create :set_start_number
  before_update :check_and_set_start_number

  def get_category
    # female racers
    if gender == 1
      return Racer.categories[:zene]
    # male racers
    elsif gender == 2
      if year_of_birth > 2001
        return Racer.categories[:u16]
      elsif (1998..2001).include? year_of_birth
        return Racer.categories[:'16-20']
      elsif (1988..1997).include? year_of_birth
        return Racer.categories[:'20-30']
      elsif (1978..1987).include? year_of_birth
        return Racer.categories[:'30-40']
      elsif (1968..1977).include? year_of_birth
        return Racer.categories[:'40-50']
      elsif year_of_birth < 1968
        return Racer.categories[:'50+']
      else
        fail 'Unknown category'
      end
    end
  end

  def set_start_number
    self.category = get_category
    self.start_number = create_start_number_for_category(self.category)
  end

  def default_start_numbers
    [600, 0, 100, 200, 300, 400, 500]
  end

  def create_start_number_for_category(category)
    category_index = Racer.categories[category]
    default_start_number = default_start_numbers[category_index]

    last_start_number = StartNumber.where(value: (default_start_number..default_start_number + 99)).or(StartNumber.where(value: (default_start_number*11..default_start_number*11 + 99))).last
    start_number_value = last_start_number.present? ? last_start_number.value + 1 : default_start_number
    # alternate numbers
    start_number_value = default_start_number*11 if start_number_value == default_start_number + 100

    # HACK for U21 category
    start_number_value = 1 if start_number_value == 0

    StartNumber.create!(value: start_number_value)
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
