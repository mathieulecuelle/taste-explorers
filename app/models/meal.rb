class Meal < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :dishes, dependent: :destroy
end
