class Item < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_many :reserving_users, through: :reservations, source: :user
  validates :name, :image, presence: true
  validates :flight_number, numericality: true
  validates :price, numericality: true
end
