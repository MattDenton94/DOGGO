class Dog < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :name, :age, :breed, :gender, :size, :temperament, presence: true
end
