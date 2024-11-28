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

require 'open-uri'
require 'faker'
Faker::Config.locale = 'fr'

# Clear existing data
Question.destroy_all
Dish.destroy_all
Booking.destroy_all
Meal.destroy_all
Preference.destroy_all
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

# Pour chaque utilisateur, créer des préférences aléatoires
ingredient_excludes = [
  'fruits de mer', 'poisson', 'oeuf', 'alcool', 'fruit à coque', 'brocoli'
]
regimes = [
  'sans produit laitier', 'sans gluten', 'sans porc', 'vegan', 'végétarien', 'pesco-végétarien'
]

# Pour chaque utilisateur, créer des préférences aléatoires
users.find_each do |user|
  # Sélectionner entre 1 et 3 ingrédients à exclure
  preference_type = 'ingrédient_exclure'
  selected_excludes = ingredient_excludes.sample(rand(1..3))
  selected_excludes.each { |exclude| user.preferences.create!(preference_type: preference_type, name: exclude) }

  # Sélectionner un régime au hasard
  preference_type = 'régime'
  selected_regime = regimes.sample
  user.preferences.create!(preference_type: preference_type, name: selected_regime)
end



# Create 10 meals
photo = URI.parse("https://i.postimg.cc/bN099LBs/frites.jpg").open
meal = Meal.create!(
  title: "Goûtez les frites de Dédé",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample,
  inspiration: "Breton", # Basé sur le titre
  heure: Time.new(2024, 1, 1, rand(18..22), 0, 0) # Heure aléatoire entre 18h et 22h
)
meal.photo.attach(io: photo, filename: "frites.jpg", content_type: "image/jpeg")
meal.save!
puts "image uploadée"

photo = URI.parse("https://i.postimg.cc/L41Tnmkk/thai.jpg").open
meal = Meal.create!(
  title: "Découvrez la cuisine thaï authentique",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample,
  inspiration: "Thaïlandaise", # Basé sur la cuisine thaï
  heure: Time.new(2024, 1, 1, rand(18..22), 0, 0)
)
meal.photo.attach(io: photo, filename: "thai.jpg", content_type: "image/jpeg")
meal.save!
puts "image uploadée"

photo = URI.parse("https://i.postimg.cc/yYCTR2nM/africa.jpg").open
meal = Meal.create!(
  title: "Saveurs authentiques de l’Afrique",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample,
  inspiration: "Africaine", # Basé sur la cuisine africaine
  heure: Time.new(2024, 1, 1, rand(18..22), 0, 0)
)
meal.photo.attach(io: photo, filename: "afri.jpg", content_type: "image/jpeg")
meal.save!
puts "image uploadée"

photo = URI.parse("https://i.postimg.cc/d3rmX9QN/italy.jpg").open
meal = Meal.create!(
  title: "Voyage culinaire en Italie avec Marco",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample,
  inspiration: "Italienne", # Cuisine italienne
  heure: Time.new(2024, 1, 1, rand(18..22), 0, 0)
)
meal.photo.attach(io: photo, filename: "italy.jpg", content_type: "image/jpeg")
meal.save!
puts "image uploadée"

photo = URI.parse("https://i.postimg.cc/mD0y8n4F/jap.jpg").open
meal = Meal.create!(
  title: "Secrets de cuisine japonaise avec Yuki",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample,
  inspiration: "Japonaise", # Cuisine japonaise
  heure: Time.new(2024, 1, 1, rand(18..22), 0, 0)
)
meal.photo.attach(io: photo, filename: "jap.jpg", content_type: "image/jpeg")
meal.save!
puts "image uploadée"

photo = URI.parse("https://i.postimg.cc/fL3v7NGN/spanish.jpg").open
meal = Meal.create!(
  title: "Soirée tapas espagnoles avec Carmen",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample,
  inspiration: "Espagnole", # Cuisine espagnole
  heure: Time.new(2024, 1, 1, rand(18..22), 0, 0)
)
meal.photo.attach(io: photo, filename: "spanish.jpg", content_type: "image/jpeg")
meal.save!
puts "image uploadée"

photo = URI.parse("https://i.postimg.cc/zf2jRBP7/indian.jpg").open
meal = Meal.create!(
  title: "Spécialités indiennes par le chef Raj",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample,
  inspiration: "Indienne", # Cuisine indienne
  heure: Time.new(2024, 1, 1, rand(18..22), 0, 0)
)
meal.photo.attach(io: photo, filename: "indian.jpg", content_type: "image/jpeg")
meal.save!
puts "image uploadée"

photo = URI.parse("https://i.postimg.cc/BQ2MwJXZ/mexican.jpg").open
meal = Meal.create!(
  title: "Saveurs authentiques du Mexique avec Maria",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample,
  inspiration: "Mexicaine", # Cuisine mexicaine
  heure: Time.new(2024, 1, 1, rand(18..22), 0, 0)
)
meal.photo.attach(io: photo, filename: "mexican.jpg", content_type: "image/jpeg")
meal.save!
puts "image uploadée"

photo = URI.parse("https://i.postimg.cc/8zHwNwRq/french.jpg").open
meal = Meal.create!(
  title: "Dîner français traditionnel chez Pierre",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample,
  inspiration: "Française", # Cuisine française
  heure: Time.new(2024, 1, 1, rand(18..22), 0, 0)
)
meal.photo.attach(io: photo, filename: "francais.jpg", content_type: "image/jpeg")
meal.save!
puts "image uploadée"

photo = URI.parse("https://i.postimg.cc/Hk5KRqvt/moyen-orient.jpg").open
meal = Meal.create!(
  title: "Saveurs du Moyen-Orient avec Leila",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample,
  inspiration: "Moyen-Orientale", # Cuisine du Moyen-Orient
  heure: Time.new(2024, 1, 1, rand(18..22), 0, 0)
)
meal.photo.attach(io: photo, filename: "nophotoss.jpg", content_type: "image/jpeg")
meal.save!
puts "image uploadée"

photo = URI.parse("https://i.postimg.cc/Dzw6Zs5m/greek.jpg").open
meal = Meal.create!(
  title: "Délices grecs avec Nikos",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample,
  inspiration: "Grecque", # Cuisine grecque
  heure: Time.new(2024, 1, 1, rand(18..22), 0, 0)
)
meal.photo.attach(io: photo, filename: "greek.jpg", content_type: "image/jpeg")
meal.save!
puts "image uploadée"

photo = URI.parse("https://i.postimg.cc/JnJhCLP1/viettt.jpg").open
meal = Meal.create!(
  title: "Cuisine vietnamienne avec Linh",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample,
  inspiration: "Vietnamienne", # Cuisine vietnamienne
  heure: Time.new(2024, 1, 1, rand(18..22), 0, 0)
)
meal.photo.attach(io: photo, filename: "viet.jpg", content_type: "image/jpeg")
meal.save!
puts "image uploadée"

photo = URI.parse("https://i.postimg.cc/HWq62rWP/brazil.jpg").open
meal = Meal.create!(
  title: "Saveurs épicées du Brésil par Carlos",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample,
  inspiration: "Brésilienne", # Cuisine brésilienne
  heure: Time.new(2024, 1, 1, rand(18..22), 0, 0)
)
meal.photo.attach(io: photo, filename: "brazil.jpg", content_type: "image/jpeg")
meal.save!
puts "image uploadée"

meals = Meal.all

# Create 10 bookings
10.times do
  Booking.create!(
    status: ['en-cours', 'confirmée', 'annulée','terminée'].sample, # Random status
    meal: meals.sample, # Assign a random meal
    user: users.sample # Assign a random user who made the booking
  )
end
bookings = Booking.all

# Créer 10 plats sans question_id
10.times do |i|
  # On génère au moins 1 entrée, 1 plat et 1 dessert pour chaque repas
  dishes = []
  dishes << { course_type: "Entrée", name: "Salade de tomates", meal_id: meals[i].id }
  dishes << { course_type: "Plat", name: "Steak frites", meal_id: meals[i].id }
  dishes << { course_type: "Dessert", name: "Crème brûlée", meal_id: meals[i].id }

  # Créer tous les plats pour le repas
  dishes.each do |dish|
    Dish.create!(dish)
  end
end
dishes = Dish.all

puts "Seeded #{User.count} users, #{Meal.count} meals, and #{Booking.count} bookings with #{Dish.count} dishes."
