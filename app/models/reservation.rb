class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validates :date, :city, presence: true
end
