class Dish < ApplicationRecord
  belongs_to :meal
  has_many :questions, dependent: :destroy

  validates :course_type, presence: true, inclusion: { in: %w[entrée plat dessert] }
  validates :name, presence: true
end
