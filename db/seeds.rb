# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |i|
  Admin.create!(name: "管理者#{i}",
              email: "kannri#{i}@example.com",
              password: "tatata")
end

20.times do |i|
  Employee.create!(name: "従業員#{i}",
              email: "zyugyoin#{i}@example.com",
              phone_number: "070-11#{i+10}-1111",
              emergency_phone_number: "070-1111-11#{i+10}",
              password: "tatata")
end
