class Meal < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :dishes, dependent: :destroy
  has_many :questions, through: :dishes

  def questions_exist?
    dishes.joins(:questions).exists?
  end
end
