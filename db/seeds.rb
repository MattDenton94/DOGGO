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

# db/seeds.rb

require "open-uri"

puts "Clearing database..."
Booking.destroy_all
Dog.destroy_all
Review.destroy_all
User.destroy_all
# Seed Users
puts "Seeding Users..."
users = User.create!([
  { email: "noku1@gmail.com", password: "password", address: "123 Main St" },
  { email: "matthew2@gmail.com", password: "password", address: "456 Oak Ave" },
  { email: "jennifer3@gmail.com", password: "password", address: "789 Pine Rd" },
])

puts "Seeded Users: #{users.map(&:email).join(', ')}"

# Seed Dogs
puts "Seeding Dogs..."
dog_images = [
  "https://www.vidavetcare.com/wp-content/uploads/sites/234/2022/04/golden-retriever-dog-breed-info.jpeg", # Buddy
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpra_Ir1mVPeS3PtlR0h9F0ThFuqL0b_zeJw&s", # Luna
  "https://www.bellaandduke.com/wp-content/uploads/2024/10/A-guide-to-German-Shepherds-characteristics-personality-lifespan-and-more-featured-image.webp", # Max
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv62BhgVkaYtdbtwvOyS0KPvW0SHkRHh08BA&s", # Bella
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpAlL6ED1U5NmmrKBTd0UxmC1FR5wIYTQBPQ&s", # Rocky
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgf1cHRiu1gvk5ZssvDOVuu7H7jK0sK-3oaw&s", # Daisy (Bulldog)
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyYJBcOgTA9_fwK9uIlUbo8sPCg98L8T9Jtg&s", # Charlie (Poodle)
]

dogs = Dog.create!([
  { name: "Buddy", age: 3, breed: "Golden Retriever", gender: "Male", size: "Large", temperament: "Friendly", user: users[0], street: "Rosmead Avenue", city: "Cape Town" },
  { name: "Luna", age: 1, breed: "Labrador Retriever", gender: "Female", size: "Medium", temperament: "Energetic", user: users[0], street: "Long Street", city: "Cape Town" },
  { name: "Max", age: 5, breed: "German Shepherd", gender: "Male", size: "Large", temperament: "Loyal", user: users[1], street: "Beach Road", city: "Cape Town" },
  { name: "Bella", age: 2, breed: "Beagle", gender: "Female", size: "Small", temperament: "Curious", user: users[1], street: "Main Road", city: "Cape Town" },
  { name: "Rocky", age: 4, breed: "Boxer", gender: "Male", size: "Medium", temperament: "Playful", user: users[2], street: "Bree Street", city: "Cape Town" },
  { name: "Daisy", age: 2, breed: "Bulldog", gender: "Female", size: "Medium", temperament: "Lazy", user: users[2], street: "Belvedere Avenue", city: "Cape Town" },
  { name: "Charlie", age: 4, breed: "Poodle", gender: "Male", size: "Small", temperament: "Intelligent", user: users[0], street: "Pinetree Avenue", city: "Cape Town" },
])

# Attach images to dogs
puts "Attaching images to dogs..."
dogs.each_with_index do |dog, index|
  file = URI.open(dog_images[index])
  dog.photo.attach(io: file, filename: "dog_#{index + 1}.jpg", content_type: "image/jpg")
end

puts "Seeded Dogs: #{dogs.map(&:name).join(', ')}"

# Seed Bookings
puts "Seeding Bookings..."
Booking.create!([
  # Bookings for User 1
  { start_date: Date.today, end_date: Date.today + 7, dog: dogs[0], user: users[0], status: "pending" }, # Buddy
  { start_date: Date.today + 8, end_date: Date.today + 15, dog: dogs[1], user: users[0], status: "pending"},  # Luna
  { start_date: Date.today + 16, end_date: Date.today + 22, dog: dogs[6], user: users[0], status: "accepted"}, # Charlie

  # Bookings for User 2
  { start_date: Date.today, end_date: Date.today + 5, dog: dogs[2], user: users[2], status: "pending"},   # Max
  { start_date: Date.today + 6, end_date: Date.today + 12, dog: dogs[3], user: users[1], status: "rejected"},  # Bella
  { start_date: Date.today + 13, end_date: Date.today + 18, dog: dogs[4], user: users[1], status: "accepted"}, # Rocky
])

puts "Seeded Bookings!"

puts "Seeding Reviews..."
Review.create!([
  { rating: 5, comment: "Buddy is such a loving and playful dog! Highly recommend.", user: users[0], booking: dogs[0].bookings.last },
  { rating: 4, comment: "Luna is energetic and fun, but a little too active for my taste.", user: users[1], booking: dogs[1].bookings.last },
  { rating: 5, comment: "Max is the most loyal and intelligent dog I have ever met. Would definitely book again!", user: users[2], booking: dogs[2].bookings.last },
  { rating: 3, comment: "Bella is a cute dog, but she can be a bit too curious and gets into things.", user: users[0], booking: dogs[3].bookings.last },
  { rating: 4, comment: "Rocky is playful and friendly, loves to run around, but a bit too excitable for younger kids.", user: users[1], booking: dogs[4].bookings.last },
  { rating: 5, comment: "Charlie is an absolute joy to be around, very intelligent and easy to train.", user: users[1], booking: dogs[6].bookings.last },
])
