class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :preferences, dependent: :destroy
   # Autoriser les préférences imbriquées
  accepts_nested_attributes_for :preferences, allow_destroy: true

  has_many :bookings, dependent: :destroy
  has_many :meals, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :encrypted_password, presence: true
  validates :first_name, :last_name, presence: true

  has_one_attached :photo
end
