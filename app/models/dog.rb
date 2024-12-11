class Dog < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :age, numericality: { only_integer: true }
  validates :breed, presence: true
  validates :gender, inclusion: { in: ["Male", "Female"] }
  validates :size, inclusion: { in: ["Small", "Medium", "Large"] }
  validates :temperament, presence: true
  validates :user_id, presence: true
end
