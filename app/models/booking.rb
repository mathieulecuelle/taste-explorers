class Booking < ApplicationRecord
  belongs_to :meal
  belongs_to :user

  validates :status, presence: true, inclusion: { in: %w[en-cours confirmée annulée terminée] }

  has_many :photos
end
