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

# Create specific users
specific_users = [
  { first_name: 'Guillaume', email: 'gui@taste.com' },
  { first_name: 'Mathieu', email: 'mat@taste.com' },
  { first_name: 'Clarisse', email: 'cla@taste.com' },
  { first_name: 'Kevin', email: 'kev@taste.com' }
]

specific_users.each do |u|
  User.create!(
    email: u[:email],
    password: 'password',
    first_name: u[:first_name],
    last_name: 'Taste', # Vous pouvez modifier le nom de famille si nécessaire
    address: Faker::Address.full_address
  )
end
users_us = User.all

# Create 10 generic users
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

# Créer des préférences pour chaque utilisateur
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

users_us.find_each do |user|
  # Sélectionner entre 1 et 3 ingrédients à exclure
  preference_type = 'ingrédient_exclure'
  selected_excludes = ingredient_excludes.sample(rand(1..3))
  selected_excludes.each { |exclude| user.preferences.create!(preference_type: preference_type, name: exclude) }

  # Sélectionner un régime au hasard
  preference_type = 'régime'
  selected_regime = regimes.sample
  user.preferences.create!(preference_type: preference_type, name: selected_regime)
end

# Définir les repas avec descriptions personnalisées
meals_data = [
  {
    title: "Goûtez les frites de Dédé",
    description: "Venez savourer les délicieuses frites préparées avec passion par Dédé. Une expérience bretonne authentique que vous n'oublierez pas !",
    photo_url: "https://i.postimg.cc/bN099LBs/frites.jpg",
    inspiration: "Breton"
  },
  {
    title: "Découvrez la cuisine thaï authentique",
    description: "Plongez dans les saveurs exotiques de la Thaïlande avec des plats authentiques préparés par un chef passionné. Une soirée inoubliable vous attend !",
    photo_url: "https://i.postimg.cc/L41Tnmkk/thai.jpg",
    inspiration: "Thaïlandaise"
  },
  {
    title: "Saveurs authentiques de l’Afrique",
    description: "Explorez la richesse culinaire africaine avec des plats traditionnels préparés avec des ingrédients locaux et des épices savoureuses.",
    photo_url: "https://i.postimg.cc/yYCTR2nM/africa.jpg",
    inspiration: "Africaine"
  },
  {
    title: "Voyage culinaire en Italie avec Marco",
    description: "Rejoignez Marco pour un voyage gastronomique en Italie. Dégustez des pâtes fraîches, des pizzas cuites au feu de bois et bien plus encore !",
    photo_url: "https://i.postimg.cc/d3rmX9QN/italy.jpg",
    inspiration: "Italienne"
  },
  {
    title: "Secrets de cuisine japonaise avec Yuki",
    description: "Découvrez les secrets de la cuisine japonaise authentique avec Yuki. Sushi, ramen, et autres délices vous attendent dans une ambiance zen.",
    photo_url: "https://i.postimg.cc/mD0y8n4F/jap.jpg",
    inspiration: "Japonaise"
  },
  {
    title: "Soirée tapas espagnoles avec Carmen",
    description: "Vivez une soirée animée avec Carmen et ses tapas espagnoles variées. Partagez des moments conviviaux autour de petites assiettes pleines de saveurs.",
    photo_url: "https://i.postimg.cc/fL3v7NGN/spanish.jpg",
    inspiration: "Espagnole"
  },
  {
    title: "Spécialités indiennes par le chef Raj",
    description: "Laissez-vous transporter par les épices et les arômes des spécialités indiennes préparées par le chef Raj. Une explosion de saveurs garantie !",
    photo_url: "https://i.postimg.cc/zf2jRBP7/indian.jpg",
    inspiration: "Indienne"
  },
  {
    title: "Saveurs authentiques du Mexique avec Maria",
    description: "Maria vous invite à découvrir les authentiques saveurs mexicaines avec des plats épicés, des tortillas maison et des margaritas rafraîchissantes.",
    photo_url: "https://i.postimg.cc/BQ2MwJXZ/mexican.jpg",
    inspiration: "Mexicaine"
  },
  {
    title: "Dîner français traditionnel chez Pierre",
    description: "Venez découvrir la cuisine française chez Pierre. Je vais vous cuisiner des plats typiques et vous allez adorer !",
    photo_url: "https://i.postimg.cc/8zHwNwRq/french.jpg",
    inspiration: "Française"
  },
  {
    title: "Saveurs du Moyen-Orient avec Leila",
    description: "Leila vous propose une immersion dans les saveurs du Moyen-Orient avec des mezzés variés, du houmous maison et des baklavas sucrés.",
    photo_url: "https://i.postimg.cc/Hk5KRqvt/moyen-orient.jpg",
    inspiration: "Moyen-Orientale"
  },
  {
    title: "Délices grecs avec Nikos",
    description: "Nikos vous accueille pour déguster des délices grecs authentiques : moussaka, tzatziki, souvlaki et bien d'autres spécialités méditerranéennes.",
    photo_url: "https://i.postimg.cc/Dzw6Zs5m/greek.jpg",
    inspiration: "Grecque"
  },
  {
    title: "Cuisine vietnamienne avec Linh",
    description: "Linh vous invite à savourer la cuisine vietnamienne avec des pho réconfortants, des rouleaux de printemps frais et des cafés glacés traditionnels.",
    photo_url: "https://i.postimg.cc/JnJhCLP1/viettt.jpg",
    inspiration: "Vietnamienne"
  },
  {
    title: "Saveurs épicées du Brésil par Carlos",
    description: "Rejoignez Carlos pour une soirée brésilienne pleine de saveurs épicées, de feijoada copieuse et de caipirinhas rafraîchissantes.",
    photo_url: "https://i.postimg.cc/HWq62rWP/brazil.jpg",
    inspiration: "Brésilienne"
  }
]

meals_data.each do |meal_data|
  photo = URI.parse(meal_data[:photo_url]).open
  meal = Meal.create!(
    title: meal_data[:title],
    description: meal_data[:description],
    duration: rand(30..180),
    location: "#{Faker::Address.city}, France",
    price_per_person: rand(10..100).to_f,
    maximum_guests: rand(1..20),
    date: Faker::Date.forward(days: 30),
    user: users.sample,
    inspiration: meal_data[:inspiration],
    heure: Time.new(2024, 1, 1, rand(18..22), 0, 0)
  )
  meal.photo.attach(io: photo, filename: "#{meal_data[:title].parameterize}.jpg", content_type: "image/jpeg")
  meal.save!
  puts "Image uploadée pour #{meal.title}"
end

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

puts "Seeded #{User.count} users, #{Meal.count} meals, et #{Booking.count} bookings avec #{Dish.count} dishes."
