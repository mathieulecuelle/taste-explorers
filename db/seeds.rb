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

# Créer une liste d'adresses spécifiques
specific_addresses = [
  "3 rue Dobrée, 44100 Nantes",
  "25 quai François Mitterrand, 44100 Nantes",
  "20 rue des Carmes, 44100 Nantes",
  "1 rue du Cheval Blanc, 44100 Nantes",
  "10 rue Cacault, 44100 Nantes",
  "6 allée Duquesne, 44100 Nantes",
  "Passage Pommeraye, 44100 Nantes",
  "23 bis rue Racine, 44100 Nantes",
  "22 rue des Carmes, 44100 Nantes",
  "1 rue de la Bâtière, 44100 Nantes",
  "15 rue de la Fosse, 44100 Nantes",
  "8 rue de l'Hôtel de Ville, 44100 Nantes",
  "4 rue de la République, 44100 Nantes",
  "12 rue du Maréchal Joffre, 44100 Nantes",
  "5 place Royale, 44100 Nantes",
  "Place des Lices, 83990 Saint-Tropez" # Nouvelle adresse ajoutée
]

# Créer des utilisateurs spécifiques (nous 4)
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

photo = URI.open("https://d26jy9fbi4q9wx.cloudfront.net/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBNXQxQXc9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--1e7c0be37ed9f59b517ccdf4976016e3389c0488/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJY0c1bkJqb0dSVlE2RTNKbGMybDZaVjkwYjE5bWFXeHNXd2hwQWNocEFjaDdCam9KWTNKdmNEb09ZWFIwWlc1MGFXOXUiLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--df4f7d63fe19fb30952f52eed6dffc392a97578c/1722623843686-removebg-preview.png")
users_us[0].photo.attach(io: photo, filename: "#{users_us[0].first_name}_photo.png", content_type: "image/png")
users_us[0].save!
puts "Image uploadée pour #{users_us[0].first_name}"

photo = URI.open("https://avatars.githubusercontent.com/u/179922336?v=4")
users_us[1].photo.attach(io: photo, filename: "#{users_us[1].first_name}_photo.png", content_type: "image/png")
users_us[1].save!
puts "Image uploadée pour #{users_us[1].first_name}"

photo = URI.open("https://avatars.githubusercontent.com/u/73218695?v=4")
users_us[2].photo.attach(io: photo, filename: "#{users_us[2].first_name}_photo.png", content_type: "image/png")
users_us[2].save!
puts "Image uploadée pour #{users_us[2].first_name}"

photo = URI.open("https://avatars.githubusercontent.com/u/157971948?v=4")
users_us[3].photo.attach(io: photo, filename: "#{users_us[3].first_name}_photo.png", content_type: "image/png")
users_us[3].save!
puts "Image uploadée pour #{users_us[3].first_name}"

# Créer 10 utilisateurs génériques
5.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: "password",
    first_name: Faker::Name.male_first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.full_address
  )
end
users = []
users = User.last(5)

photo = URI.open("https://avatars.githubusercontent.com/u/145620308?v=4")
users[0].photo.attach(io: photo, filename: "#{users[0].first_name}_photo.png", content_type: "image/png")
users[0].save!
puts "Image uploadée pour #{users[0].first_name}"

photo = URI.open("https://avatars.githubusercontent.com/u/184125948?v=4")
users[1].photo.attach(io: photo, filename: "#{users[1].first_name}_photo.png", content_type: "image/png")
users[1].save!
puts "Image uploadée pour #{users[1].first_name}"

photo = URI.open("https://avatars.githubusercontent.com/u/78415911?v=4")
users[2].photo.attach(io: photo, filename: "#{users[2].first_name}_photo.png", content_type: "image/png")
users[2].save!
puts "Image uploadée pour #{users[3].first_name}"

photo = URI.open("https://avatars.githubusercontent.com/u/31104847?v=4")
users[3].photo.attach(io: photo, filename: "#{users[3].first_name}_photo.png", content_type: "image/png")
users[3].save!
puts "Image uploadée pour #{users[3].first_name}"

photo = URI.open("https://avatars.githubusercontent.com/u/176056394?v=4")
users[4].photo.attach(io: photo, filename: "#{users[4].first_name}_photo.png", content_type: "image/png")
users[4].save!
puts "Image uploadée pour #{users[4].first_name}"

5.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: "password",
    first_name: Faker::Name.female_first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.full_address
  )
end

users.concat(User.last(5))

photo = URI.open("https://avatars.githubusercontent.com/u/184098156?v=4")
users[5].photo.attach(io: photo, filename: "#{users[5].first_name}_photo.png", content_type: "image/png")
users[5].save!
puts "Image uploadée pour #{users[5].first_name}"


photo = URI.open("https://avatars.githubusercontent.com/u/160630691?v=4")
users[6].photo.attach(io: photo, filename: "#{users[6].first_name}_photo.png", content_type: "image/png")
users[6].save!
puts "Image uploadée pour #{users[6].first_name}"


photo = URI.open("https://avatars.githubusercontent.com/u/39617224?v=4")
users[7].photo.attach(io: photo, filename: "#{users[7].first_name}_photo.png", content_type: "image/png")
users[7].save!
puts "Image uploadée pour #{users[7].first_name}"


photo = URI.open("https://avatars.githubusercontent.com/u/183993846?v=4")
users[8].photo.attach(io: photo, filename: "#{users[8].first_name}_photo.png", content_type: "image/png")
users[8].save!
puts "Image uploadée pour #{users[8].first_name}"


photo = URI.open("https://d26jy9fbi4q9wx.cloudfront.net/rails/active_storage/representations/proxy/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBeWg4QXc9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--ea77f2d4002b37df8ae1550aa65b99f911c600e1/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJYW5CbkJqb0dSVlE2RTNKbGMybDZaVjkwYjE5bWFXeHNXd2hwQWNocEFjaDdCam9KWTNKdmNEb09ZWFIwWlc1MGFXOXUiLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--b67d9ded4d28d0969fbb98b4c21b79257705a99a/4043498e-c48b-45d6-80a6-5574774a57a2.jpg")
users[9].photo.attach(io: photo, filename: "#{users[9].first_name}_photo.png", content_type: "image/png")
users[9].save!
puts "Image uploadée pour #{users[9].first_name}"


# Pour chaque utilisateur, créer des préférences aléatoires
ingredient_excludes = [
  'fruits de mer', 'poisson', 'oeuf', 'alcool', 'fruit à coque', 'brocoli'
]
regimes = [
  'Sans lactose', 'Sans gluten', 'Sans porc', 'Vegan', 'Végé'
]

# Créer des préférences pour chaque utilisateur
users.each do |user|
  # Sélectionner entre 1 et 3 ingrédients à exclure
  preference_type = 'ingrédient_exclure'
  selected_excludes = ingredient_excludes.sample(rand(1..3))
  selected_excludes.each { |exclude| user.preferences.create!(preference_type: preference_type, name: exclude) }

  # Sélectionner un régime au hasard
  preference_type = 'régime'
  selected_regime = regimes.sample
  user.preferences.create!(preference_type: preference_type, name: selected_regime)
end

users_us.each do |user|
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
    title: "Goûtez nos superbes frites",
    description: "Venez savourer les délicieuses frites préparées avec passion. Une expérience bretonne authentique que vous n'oublierez pas !",
    photo_url: "https://i.postimg.cc/bN099LBs/frites.jpg",
    inspiration: "Breton",
    dish_entree: "Chèvre & chips",
    dish_plat: "Moules-frites",
    dish_dessert:"Churros choco"
  },
  {
    title: "Découvrez la cuisine thaï authentique",
    description: "Plongez dans les saveurs exotiques de la Thaïlande avec des plats authentiques préparés par un chef passionné. Une soirée inoubliable vous attend !",
    photo_url: "https://i.postimg.cc/L41Tnmkk/thai.jpg",
    inspiration: "Thaïlandaise",
    dish_entree: "Som Tam",
    dish_plat: "Pad Thaï",
    dish_dessert:"Mango Sticky Rice"
  },
  {
    title: "Saveurs authentiques de l’Afrique",
    description: "Explorez la richesse culinaire africaine avec des plats traditionnels préparés avec des ingrédients locaux et des épices savoureuses.",
    photo_url: "https://i.postimg.cc/yYCTR2nM/africa.jpg",
    inspiration: "Africaine",
    dish_entree: "Accra",
    dish_plat: "Yassa Poulet",
    dish_dessert:"Bissap"
  },
  {
    title: "Voyage culinaire en Italie",
    description: "Rejoignez nous pour un voyage gastronomique en Italie. Dégustez des pâtes fraîches, des pizzas cuites au feu de bois et bien plus encore !",
    photo_url: "https://i.postimg.cc/d3rmX9QN/italy.jpg",
    inspiration: "Italienne",
    dish_entree: "Bruschetta",
    dish_plat: "Pizza Margherita",
    dish_dessert:"Tiramisu"
  },
  {
    title: "Secrets de cuisine japonaise",
    description: "Découvrez les secrets de la cuisine japonaise authentique. Sushi, ramen, et autres délices vous attendent dans une ambiance zen.",
    photo_url: "https://i.postimg.cc/mD0y8n4F/jap.jpg",
    inspiration: "Japonaise",
    dish_entree: "Edamame",
    dish_plat: "Sushi Maki",
    dish_dessert:"Mochi"
  },
  {
    title: "Soirée tapas espagnoles",
    description: "Vivez avec nous une soirée animée et ses tapas espagnoles variées. Partagez des moments conviviaux autour de petites assiettes pleines de saveurs.",
    photo_url: "https://i.postimg.cc/fL3v7NGN/spanish.jpg",
    inspiration: "Espagnole",
    dish_entree: "Patatas Bravas",
    dish_plat: "Paella",
    dish_dessert:"Churros"
  },
  {
    title: "Spécialités indiennes",
    description: "Laissez-vous transporter par les épices et les arômes des spécialités indiennes préparées. Une explosion de saveurs garantie !",
    photo_url: "https://i.postimg.cc/zf2jRBP7/indian.jpg",
    inspiration: "Indienne",
    dish_entree: "Samosas",
    dish_plat: "Chicken Tikka",
    dish_dessert:"Gulab Jamun"
  },
  {
    title: "Saveurs authentiques du Mexique avec Maria",
    description: "Maria vous invite à découvrir les authentiques saveurs mexicaines avec des plats épicés, des tortillas maison et des margaritas rafraîchissantes.",
    photo_url: "https://i.postimg.cc/BQ2MwJXZ/mexican.jpg",
    inspiration: "Mexicaine",
    dish_entree: "Guacamole",
    dish_plat: "Tacos al pastor",
    dish_dessert:"Flan Mexicain"
  },
  {
    title: "Dîner français traditionnel",
    description: "Venez découvrir la cuisine française. Je vais vous cuisiner des plats typiques et vous allez adorer !",
    photo_url: "https://i.postimg.cc/8zHwNwRq/french.jpg",
    inspiration: "Française",
    dish_entree: "Soupe à l'oignon",
    dish_plat: "Coq au vin",
    dish_dessert:"Crème brûlée"
  },
  {
    title: "Saveurs du Moyen-Orient",
    description: "Leila vous propose une immersion dans les saveurs du Moyen-Orient avec des mezzés variés, du houmous maison et des baklavas sucrés.",
    photo_url: "https://i.postimg.cc/Hk5KRqvt/moyen-orient.jpg",
    inspiration: "Moyen-Orientale",
    dish_entree: "Houmous",
    dish_plat: "Shawarma",
    dish_dessert:"Baklava"
  },
  {
    title: "Délices grecs",
    description: "Je vous accueille pour déguster des délices grecs authentiques : moussaka, tzatziki, souvlaki et bien d'autres spécialités méditerranéennes.",
    photo_url: "https://i.postimg.cc/Dzw6Zs5m/greek.jpg",
    inspiration: "Grecque",
    dish_entree: "Tzatziki",
    dish_plat: "Moussaka",
    dish_dessert:"Baklava"
  },
  {
    title: "Cuisine vietnamienne",
    description: "Je vous invite à savourer la cuisine vietnamienne avec des pho réconfortants, des rouleaux de printemps frais et des cafés glacés traditionnels.",
    photo_url: "https://i.postimg.cc/JnJhCLP1/viettt.jpg",
    inspiration: "Vietnamienne",
    dish_entree: "Nem",
    dish_plat: "Pho",
    dish_dessert:"Che Ba Mau"
  },
  {
    title: "Saveurs épicées du Brésil",
    description: "Rejoignez nous pour une soirée brésilienne pleine de saveurs épicées, de feijoada copieuse et de caipirinhas rafraîchissantes.",
    photo_url: "https://i.postimg.cc/HWq62rWP/brazil.jpg",
    inspiration: "Brésilienne",
    dish_entree: "Pão de Queijo",
    dish_plat: "Feijoada",
    dish_dessert:"Pudim"
  }
]

# S'assurer que le nombre d'adresses correspond au nombre de repas
if specific_addresses.size < meals_data.size + 2 # +2 pour les repas spécifiques
  puts "Erreur : Il y a moins d'adresses spécifiques que de repas."
  exit
end

meals_data.each_with_index do |meal_data, index|
  photo = URI.open(meal_data[:photo_url])
  # users_array = [users_us, users].sample # Choisit aléatoirement entre users_us et users
  users_array = users
  meal = Meal.create!(
    title: meal_data[:title],
    description: meal_data[:description],
    duration: rand(2..5),
    location: specific_addresses[index], # Utiliser l'adresse spécifique
    price_per_person: rand(10..100).to_f,
    maximum_guests: rand(4..15),
    date: Faker::Date.forward(days: 30),
    user: users_array.sample,
    inspiration: meal_data[:inspiration],
    heure: Time.new(2024, 1, 1, rand(18..22), 0, 0)
  )
  meal.photo.attach(io: photo, filename: "#{meal_data[:title].parameterize}.jpg", content_type: "image/jpeg")
  meal.save!

  # Créer tous les plats pour le repas
  dishes = []
  dishes << { course_type: "Entrée", name: meal_data[:dish_entree], meal_id: meal.id }
  dishes << { course_type: "Plat", name: meal_data[:dish_plat], meal_id: meal.id }
  dishes << { course_type: "Dessert", name: meal_data[:dish_dessert], meal_id: meal.id }
  dishes.each do |dish|
    Dish.create!(dish)
  end

  puts "Image uploadée pour #{meal.title}"
end

# Créer le repas à Saint-Tropez
stp_photo_url = "https://i.postimg.cc/G3YFhXN5/st-tropez.jpg" # Remplacez par l'URL de votre photo
stp_photo = URI.open(stp_photo_url)

stp_meal = Meal.create!(
  title: "Repas à Saint-Tropez",
  description: "Venez déguster un délicieux repas à Saint-Tropez, au cœur de la Côte d'Azur. Profitez d'une ambiance festive et de mets raffinés dans un cadre idyllique.",
  duration: rand(2..5), # Durée en minutes
  location: "Place des Lices, 83990 Saint-Tropez", # Adresse spécifique ajoutée précédemment
  price_per_person: 75.0, # Prix par personne
  maximum_guests: 10, # Nombre maximal d'invités
  date: Faker::Date.forward(days: 60), # Date aléatoire dans les 60 prochains jours
  user: users.sample, # Assignation aléatoire d'un utilisateur
  inspiration: "Française",
  heure: Time.new(2024, 5, 20, rand(18..22), 0, 0) # Date et heure spécifiques (ajustez si nécessaire)
)
stp_meal.photo.attach(io: stp_photo, filename: "repas-saint-tropez.jpg", content_type: "image/jpeg")
stp_meal.save!
puts "Image uploadée pour #{stp_meal.title}"

# Créer tous les plats pour le repas
dishes = []
dishes << { course_type: "Entrée", name: "Salade niçoise", meal_id: stp_meal.id }
dishes << { course_type: "Plat", name: "Bouillabaisse", meal_id: stp_meal.id }
dishes << { course_type: "Dessert", name: "Tarte tropézienne", meal_id: stp_meal.id }
dishes.each do |dish|
  Dish.create!(dish)
end

# Créer le repas de Noël
noel_photo_url = "https://i.postimg.cc/V6ZVfDV6/noel.jpg" # Remplacez par l'URL de votre photo
noel_photo = URI.open(noel_photo_url)

noel_meal = Meal.create!(
  title: "Repas de Noël",
  description: "Célébrez Noël avec un repas festif spécial, entouré de famille et amis. Savourez des plats traditionnels et profitez d'une ambiance chaleureuse et conviviale.",
  duration: rand(2..5), # Durée en minutes
  location: "5 place Royale, 44100 Nantes", # Utilisez une adresse spécifique existante ou ajoutez-en une nouvelle si nécessaire
  price_per_person: 100.0, # Prix par personne
  maximum_guests: 10, # Nombre maximal d'invités
  date: Date.new(2024, 12, 24), # Date spécifique du repas
  user: users.sample, # Assignation aléatoire d'un utilisateur
  inspiration: "Noël",
  heure: Time.new(2024, 12, 24, 19, 0, 0) # Date et heure spécifiques
)
noel_meal.photo.attach(io: noel_photo, filename: "repas-de-noel.jpg", content_type: "image/jpeg")
noel_meal.save!
puts "Image uploadée pour #{noel_meal.title}"

# Créer tous les plats pour le repas
dishes = []
dishes << { course_type: "Entrée", name: "Foie gras", meal_id: noel_meal.id }
dishes << { course_type: "Plat", name: "Dinde farcie", meal_id: noel_meal.id }
dishes << { course_type: "Dessert", name: "Bûche de Noël", meal_id: noel_meal.id }
dishes.each do |dish|
  Dish.create!(dish)
end

meals = Meal.all

# Create 10 bookings sur les users "users"
10.times do
  Booking.create!(
    status: 'confirmée',
    meal: meals.sample, # Assignation aléatoire d'un repas
    user: users.sample # Assignation aléatoire d'un utilisateur
  )
end
bookings = Booking.all

# # Create 5 bookings sur les users "users"
# 5.times do
#   Booking.create!(
#     status: 'confirmée',
#     meal: meals.sample, # Assignation aléatoire d'un repas
#     user: users_us.sample # Assignation aléatoire d'un utilisateur
#   )
# end
# bookings_us = Booking.last(5)

puts "Seeded #{User.count} users, #{Meal.count} meals, et #{Booking.count} bookings."
