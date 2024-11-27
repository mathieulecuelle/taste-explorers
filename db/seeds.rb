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
  # Choisir un type aléatoire entre 'ingrédient_exclure' ou 'régime'
  preference_type = ['ingrédient_exclure', 'régime'].sample

  if preference_type == 'ingrédient_exclure'
    # Sélectionner entre 1 et 3 ingrédients à exclure
    selected_excludes = ingredient_excludes.sample(rand(1..3))
    selected_excludes.each { |exclude| user.preferences.create!(preference_type: preference_type, name: exclude) }
  else
    # Sélectionner un régime au hasard
    selected_regime = regimes.sample
    user.preferences.create!(preference_type: preference_type, name: selected_regime)
  end
end




# Create 10 meals
# Create 10 meals
Meal.create!(
  title: "Goûtez les frites de Dédé",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Découvrez la cuisine thaï authentique",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Saveurs authentiques de l’Afrique",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Voyage culinaire en Italie avec Marco",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Secrets de cuisine japonaise avec Yuki",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Soirée tapas espagnoles avec Carmen",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Spécialités indiennes par le chef Raj",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Saveurs authentiques du Mexique avec Maria",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Dîner français traditionnel chez Pierre",
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
  title: "Délices grecs avec Nikos",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Cuisine vietnamienne avec Linh",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

Meal.create!(
  title: "Saveurs épicées du Brésil par Carlos",
  description: Faker::Lorem.paragraph(sentence_count: 2),
  duration: rand(30..180),
  location: Faker::Address.city,
  price_per_person: rand(10..100).to_f,
  maximum_guests: rand(1..20),
  date: Faker::Date.forward(days: 30),
  user: users.sample
)

meals = Meal.all

# Create 10 bookings
10.times do
  Booking.create!(
    status: ['en-cours', 'confirmée', 'annulée','terminée'].sample, # Random status
    meal: meals.sample, # Assign a random meal
    user: users.sample # Assign a random user who made the booking
  )
end

# Créer 10 plats sans question_id
10.times do |i|
  # On génère au moins 1 entrée, 1 plat et 1 dessert pour chaque repas
  dishes = []
  dishes << { course_type: "entrée", name: "Salade de tomates", meal_id: meals[i].id }
  dishes << { course_type: "plat", name: "Steak frites", meal_id: meals[i].id }
  dishes << { course_type: "dessert", name: "Crème brûlée", meal_id: meals[i].id }

  # Créer tous les plats pour le repas
  dishes.each do |dish|
    Dish.create(dish)
  end
end

puts "Seeded #{User.count} users, #{Meal.count} meals, and #{Booking.count} bookings with #{Dish.count} dishes."
