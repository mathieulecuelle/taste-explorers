class Dish < ApplicationRecord
  belongs_to :meal
  has_many :questions, dependent: :destroy


  COURSE_TYPES = ['Entrée', 'Plat', 'Dessert'].freeze
  validates :course_type, inclusion: { in: COURSE_TYPES }
  
  validates :name, presence: true

end
