class User < ApplicationRecord
  has_many :dogs, dependent: :destroy
  has_many :bookings, dependent: :destroy
end
