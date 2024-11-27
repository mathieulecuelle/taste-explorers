class Question < ApplicationRecord
  belongs_to :dish

  validates :question, presence: true
  validates :options_answers, presence: true
  validates :answer, presence: true
end
