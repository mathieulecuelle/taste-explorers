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

require 'faker'
Faker::Config.locale = 'fr'

# Clear existing data
Booking.destroy_all
Meal.destroy_all
User.destroy_all

# Create 10 users
10.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.full_address
  )
end

users = User.all

# Create 10 meals
Meal.create!(
  title: "Dédé fait goûter ses frites",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180), # Duration in minutes
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f, # Price as a decimal
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample # Assign a random user as the creator of the meal
)

Meal.create!(
  title: "Découvrez la vraie cuisine thaï!",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180), # Duration in minutes
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f, # Price as a decimal
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample # Assign a random user as the creator of the meal
)

Meal.create!(
  title: "Plongez dans les saveurs authentiques de l'Afrique",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180), # Duration in minutes
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f, # Price as a decimal
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample # Assign a random user as the creator of the meal
)

Meal.create!(
  title: "Voyage gustatif en Italie avec Marco",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Les secrets de la cuisine japonaise révélés par Yuki",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Une soirée tapas espagnoles avec Carmen",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Dégustation de spécialités indiennes par Raj",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Le goût authentique du Mexique avec Maria",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Un dîner français traditionnel chez Pierre",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Saveurs du Moyen-Orient avec Leila",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Délices grecs à la table de Nikos",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Une soirée à la découverte de la cuisine vietnamienne avec Linh",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days:30),
  user: users.sample
)

Meal.create!(
  title:"Les saveurs épicées du Brésil par Carlos",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location:Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date:Faker::Date.forward(days:30),
  user:users.sample
)



meals = Meal.all

# Create 10 bookings
10.times do
  Booking.create!(
    status: ['pending', 'confirmed', 'canceled'].sample, # Random status
    meal: meals.sample, # Assign a random meal
    user: users.sample # Assign a random user who made the booking
  )
end

puts "Seeded #{User.count} users, #{Meal.count} meals, and #{Booking.count} bookings."
