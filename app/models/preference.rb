class Preference < ApplicationRecord
  belongs_to :user

  PREFERENCE_TYPES = ['ingrédient_exclure','régime'].freeze
  validates :preference_type, presence: true, inclusion: { in: PREFERENCE_TYPES }
  validates :name, presence: true
end
