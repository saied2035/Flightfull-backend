class User < ApplicationRecord
  has_secure_password
  has_many :items, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :reserved_items, through: :reservations, source: :item

  validates :name, uniqueness: true
end
