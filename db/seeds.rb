# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name: "Admin user",
             email: "admin@ror.org",
             username: "admin",
             password: "password1234",
             password_confirmation: "password1234",
             admin: true)

99.times do |n|
  name = "User #{n+1}"
  email = "user-#{n+1}@gmail.com"
  username = "user-#{n+1}"
  password = "password1234"
  User.create!(name: name,
               email: email,
               username: username,
               password: password,
               password_confirmation: password)

end