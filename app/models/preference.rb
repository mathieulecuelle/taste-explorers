class Preference < ApplicationRecord
  belongs_to :user

  validates :preference_type, presence: true, inclusion: { in: %w[ingrédient_exclure régime] }
  validates :name, presence: true
end
