# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: 'Admin', last_name: 'Admin', username: 'admin', email: 'admin@factoro_test.com', password: 'admin', password_confirmation: 'admin')
User.create(name: 'Pastor', last_name: 'Talavera', username: 'talavecp', email: 'talaveracp@gmail.com', password: 'admin', password_confirmation: 'admin')