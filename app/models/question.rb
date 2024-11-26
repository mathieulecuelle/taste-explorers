class Question < ApplicationRecord
  has_many :dishes

  validates :question, presence: true
  validates :answer, presence: true
end
