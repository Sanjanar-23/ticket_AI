# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

puts 'Creating 100 fake tickets...'

100.times do
  Ticket.create!(
    company_name: Faker::Company.name,
    customer_name: Faker::Name.name,
    customer_number: Faker::Number.number(digits: 10),  # max 9 digits fits integer limit
    issue: Faker::Lorem.sentence(word_count: 5),       # text field for issue description
    created_date: Faker::Date.backward(days: 365)     # random date in last year
  )
end

puts 'Finished!'
