class AddStatusToBookings < ActiveRecord::Migration[7.2]
  def change
    add_column :bookings, :status, :string
    add_column :bookings, :default, :string
    add_column :bookings, :pending, :string
  end
end
