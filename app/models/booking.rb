class Booking < ApplicationRecord
  belongs_to :meal
  belongs_to :user

  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= "accepted"
  end
end
