class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :dog
  has_many :reviews, dependent: :destroy
  validates :start_date, :end_date, presence: true

  validate :no_overlapping_bookings, on: [:create, :update]

  private


  def no_overlapping_bookings

    conflicting_bookings = Booking.where(dog: dog)
                                  .where.not(id: id)
                                  .where("start_date < ? AND end_date > ?", end_date, start_date)

    if conflicting_bookings.exists?
      errors.add(:base, "There is already a booking for this dog during the selected dates.")
    end
  end
end
