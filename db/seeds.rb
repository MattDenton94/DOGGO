# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Creating Dogs

# Clear Database
# Clear Database
puts "Clearing database..."
Booking.destroy_all
Dog.destroy_all
User.destroy_all
Review.destroy_all

# Seed Users
puts "Seeding Users..."
users = User.create!([
  { email: "alice@example.com", password: "password", address: "123 Main St" },
  { email: "bob@example.com", password: "password", address: "456 Oak Ave" },
  { email: "charlie@example.com", password: "password", address: "789 Pine Rd" }
])
puts "Seeded Users: #{users.map(&:email).join(', ')}"

# Seed Dogs
puts "Seeding Dogs..."
dogs = Dog.create!([
  { name: "Buddy", age: 3, breed: "Golden Retriever", gender: "Male", size: "Large", temperament: "Friendly", user: users[0] },
  { name: "Luna", age: 1, breed: "Labrador Retriever", gender: "Female", size: "Medium", temperament: "Energetic", user: users[1] },
  { name: "Max", age: 5, breed: "German Shepherd", gender: "Male", size: "Large", temperament: "Loyal", user: users[2] },
  { name: "Bella", age: 2, breed: "Beagle", gender: "Female", size: "Small", temperament: "Curious", user: users[0] },
  { name: "Rocky", age: 4, breed: "Boxer", gender: "Male", size: "Medium", temperament: "Playful", user: users[1] }
])
puts "Seeded Dogs: #{dogs.map(&:name).join(', ')}"

# Seed Bookings
puts "Seeding Bookings..."
Booking.create!([
  { start_date: Date.today, end_date: Date.today + 7, dog: dogs[0], user: users[0] },
  { start_date: Date.today + 10, end_date: Date.today + 15, dog: dogs[1], user: users[1] },
  { start_date: Date.today + 20, end_date: Date.today + 25, dog: dogs[2], user: users[2] },
  { start_date: Date.today + 30, end_date: Date.today + 35, dog: dogs[3], user: users[0] },
  { start_date: Date.today + 40, end_date: Date.today + 45, dog: dogs[4], user: users[1] }
])
puts "Seeded Bookings!"
