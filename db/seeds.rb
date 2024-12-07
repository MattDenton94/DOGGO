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

puts "Clearing database..."
Dog.destroy_all

Dog.create([
  {
    name: "Buddy",
    age: 3,
    breed: "Golden Retriever",
    gender: "Male",
    size: "Large",
    temperament: "Friendly",
    user_id: 1
  },
  {
    name: "Luna",
    age: 1,
    breed: "Labrador Retriever",
    gender: "Female",
    size: "Medium",
    temperament: "Energetic",
    user_id: 2
  },
  {
    name: "Max",
    age: 5,
    breed: "German Shepherd",
    gender: "Male",
    size: "Large",
    temperament: "Loyal",
    user_id: 3
  },
  {
    name: "Bella",
    age: 2,
    breed: "Beagle",
    gender: "Female",
    size: "Small",
    temperament: "Curious",
    user_id: 1
  },
  {
    name: "Rocky",
    age: 4,
    breed: "Boxer",
    gender: "Male",
    size: "Medium",
    temperament: "Playful",
    user_id: 2
  }
])

puts "Seeded Dogs!"
