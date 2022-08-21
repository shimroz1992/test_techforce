# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(first_name: "shimroz", last_name: "Ahmed", role: "Admin", is_admin: true, password: '123456', email: "sample@gmail.com", user_name: "sample")

5.times do |n| 
User.create(first_name: "shimroz", last_name: "Ahmed", role: "Admin", is_admin: true, password: '123456', email: "#{n}-sample@gmail.com", user_name: "sample=#{n}")
end