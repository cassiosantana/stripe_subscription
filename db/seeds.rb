# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

begin
  Stripe::Plan.create(
    product: { name: "Premium", id: "premium" },
    id: "premium",
    interval: "month",
    billing_scheme: "per_unit",
    currency: "usd",
    amount: "5000"
  )
rescue Stripe::InvalidRequestError => e
  puts "Premium plan failed to create: #{e.message}"
end