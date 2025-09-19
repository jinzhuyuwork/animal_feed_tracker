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
corn = Feed.create!(name: "Corn Mix", category: "feed", protein: 8.0, fat: 3.5, fiber: 5.0, vitamins: "A,D,E", minerals: "Ca,P")
soy = Feed.create!(name: "Soy Meal", category: "feed", protein: 44.0, fat: 1.5, fiber: 6.0, vitamins: "B12", minerals: "Mg,Zn")
barley = Feed.create!(name: "Barley Feed", category: "feed", protein: 10.0, fat: 2.0, fiber: 8.0, vitamins: "E", minerals: "K,Fe")
zinpro_availa_zn = Feed.create!(name: "Zinpro Availa Zn", category: "mineral", protein: nil, fat: nil, fiber: nil, vitamins: nil, minerals: "Zn")
zinpro_availa_cr = Feed.create!(name: "Zinpro Availa Cr", category: "mineral", protein: nil, fat: nil, fiber: nil, vitamins: nil, minerals: "Cr")
zinpro_profusion = Feed.create!(name: "Zinpro ProFusion", category: "supplement", protein: nil, fat: nil, fiber: nil, vitamins: nil, minerals: "Zn,Mg,Cu,Caru,KI")

# Create sample formulations
Formulation.create!(animal: cow, feed: corn, quantity: 5.0, name: "High Protein", description: "High protein formula")
Formulation.create!(animal: cow, feed: soy, quantity: 2.0, name: "Low fat", description: "Low fat formula")
Formulation.create!(animal: cow, feed: zinpro_profusion, quantity: 0.1, name: "Minerals and other nutrients", description: "Supply of essential trace minerals and other nutrients.")
Formulation.create!(animal: chicken, feed: corn, quantity: 0.5, name: "Low protein", description: "Low protein formula")
Formulation.create!(animal: chicken, feed: barley, quantity: 0.3, name: "Balance feed", description: "Balance nutrition formula")
Formulation.create!(animal: chicken, feed: zinpro_availa_zn, quantity: 0.01, name: "Zinc supplement", description: "Improves hoof integrity, immune response, reproduction, skin health")
Formulation.create!(animal: pig, feed: soy, quantity: 3.0, name: "Medium Protein", description: "This is a formula with medium protein")
Formulation.create!(animal: pig, feed: barley, quantity: 2.5, name: "High Fiber", description: "This is a formula with high fiber")
Formulation.create!(animal: pig, feed: zinpro_availa_cr, quantity: 0.01, name: "Copper supplement", description: "Immune support, growth, reproductive performance.")

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
