# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Role.create(name: "Project Manager", is_active: true)
Role.create(name: "Project Coordinator", is_active: true)
Role.create(name: "Developer", is_active: true)
User.invite!(:email => "wgsticketing@gmail.com")
