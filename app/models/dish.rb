class Dish < ApplicationRecord
  belongs_to :meal
  belongs_to :question, optional: true, dependent: :destroy
end
