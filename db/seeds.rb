# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admins 
admin = User.create(name: "Admin", password: "pass", role: "Admin")

# Teachers
laura = User.create(name: "Laura C", password: "pass", role: "Teacher")
catherine = User.create(name: "Catherine", password: "pass", role: "Teacher")
lou_anne = User.create(name: "Lou Ann", password: "pass", role: "Teacher")

# Students 
nita = User.create(name: "Nita", password: "pass", role: "Student")
charlie = User.create(name: "Charlie", password: "pass", role: "Student")
tim = User.create(name: "Tim", password: "pass", role: "Student")


