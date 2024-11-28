class Meal < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :dishes, dependent: :destroy
  has_many :questions, through: :dishes

  validates :title, :description, :location, :price_per_person, :maximum_guests, :date, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }
  validates :price_per_person, numericality: { greater_than_or_equal_to: 0 }
  validates :maximum_guests, numericality: { only_integer: true, greater_than: 0 }
  validates :title, length: { maximum: 50 }

  def questions_exist?
    dishes.joins(:questions).exists?
  end

  has_one_attached :photo
  geocoded_by :location, latitude: :gps_latitude, longitude: :gps_longitude
  after_validation :geocode, if: :will_save_change_to_location?
end
