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

friendship = Course.create(name: "Friendship", description: "learn how to make friends", capacity: 14, location: "Boardroom",
    weekly_schedule: "Mon/Wed/Fri", duration: 60, military_start_time: "09:00:00")
painting = Course.create(name: "Painting", description: "learn how to paint", capacity: 15, location: "artroom",
    weekly_schedule: "Mon/Wed/Fri", duration: 60, military_start_time: "10:00:00")
magazine = Course.create(name: "Magazine", description: "look through magazines", capacity: 12, location: "house",
    weekly_schedule: "Tue/Thu", duration: 30, military_start_time: "13:30:00")
relationship = Course.create(name: "Relationship", description: "learn about healthy relationships", capacity: 10, location: "Office",
    weekly_schedule: "Tue/Thu", duration: 60, military_start_time: "9:00:00")
horses = Course.create(name: "Horses", description: "learn how to ride and care for horses", capacity: 4, location: "barn",
    weekly_schedule: "Mon/Wed/Fri", duration: 90, military_start_time: "13:00:00")
beading = Course.create(name: "Beading", description: "learn how to bead", capacity: 6, location: "building",
    weekly_schedule: "Mon/Wed/Fri", duration: 120, military_start_time: "8:00:00")

# Teachers
laura.courses << friendship
laura.courses << relationship
laura.courses << beading

catherine.courses << beading
catherine.courses << magazine
catherine.courses << painting

lou_anne.courses << horses
lou_anne.courses << friendship
lou_anne.courses << magazine

# Students
nita.courses << friendship
tim.courses << relationship
charlie.courses << beading

nita.courses << beading
tim.courses << magazine
charlie.courses << painting

nita.courses << horses
tim.courses << friendship
charlie.courses << magazine


