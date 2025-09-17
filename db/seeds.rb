# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Destroy old records (optional)
Formulation.destroy_all
Animal.destroy_all
Feed.destroy_all

# Create sample animals
cow = Animal.create!(name: "Bessie", species: "Cow", age: 4, weight: 450.5)
chicken = Animal.create!(name: "Clucky", species: "Chicken", age: 1, weight: 2.3)
pig = Animal.create!(name: "Porky", species: "Pig", age: 2, weight: 120.0)

# Create sample feeds
corn = Feed.create!(name: "Corn Mix", protein: 8.0, fat: 3.5, fiber: 5.0, vitamins: "A,D,E", minerals: "Ca,P")
soy = Feed.create!(name: "Soy Meal", protein: 44.0, fat: 1.5, fiber: 6.0, vitamins: "B12", minerals: "Mg,Zn")
barley = Feed.create!(name: "Barley Feed", protein: 10.0, fat: 2.0, fiber: 8.0, vitamins: "E", minerals: "K,Fe")

# Create sample formulations
Formulation.create!(animal: cow, feed: corn, quantity: 5.0, name: "High Protein", description: "This is a formula with high protein")
Formulation.create!(animal: cow, feed: soy, quantity: 2.0, name: "Low fat", description: "This is a formula with low fat")
Formulation.create!(animal: chicken, feed: corn, quantity: 0.5, name: "Low protein", description: "This is a formula with low protein")
Formulation.create!(animal: chicken, feed: barley, quantity: 0.3, name: "Balance feed", description: "This is a formula with balance nutrition")
Formulation.create!(animal: pig, feed: soy, quantity: 3.0, name: "Medium Protein", description: "This is a formula with medium protein")
Formulation.create!(animal: pig, feed: barley, quantity: 2.5, name: "High Fiber", description: "This is a formula with high fiber")

# Create default admin user for testing authentication
User.destroy_all

User.create!(
  email: 'admin@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  admin: true
)

User.create!(
  email: 'guest@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  admin: false
)