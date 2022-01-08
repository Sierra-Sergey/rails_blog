# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require "faker"

5.times do
  authors = Author.new(
    gender: Faker::Gender.binary_type,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 50)
  )
  authors.save
end
