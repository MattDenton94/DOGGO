class Dog < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_name_and_breed,
    against: [ :name, :breed ],
    using: {
      tsearch: { prefix: true }
    }

  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  has_one_attached :photo
end
