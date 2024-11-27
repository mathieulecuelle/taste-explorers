class Dish < ApplicationRecord
  belongs_to :meal
  has_many :questions, dependent: :destroy
end
