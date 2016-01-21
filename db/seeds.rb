# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Item.create!(name: "Book",
             basic_tax: false,
             duty: false,
             price: 12.49)
             
Item.create!(name: "Music CD",
             basic_tax: true,
             duty: false,
             price: 14.99)
             
Item.create!(name: "Chocolate bar",
             basic_tax: false,
             duty: false,
             price: 0.85)

Item.create!(name: "Imported box of chocolates",
             basic_tax: false,
             duty: true,
             price: 10)

Item.create!(name: "Imported bottle of perfume",
             basic_tax: true,
             duty: true,
             price: 47.5)

Item.create!(name: "Imported bottle of perfume",
             basic_tax: true,
             duty: true,
             price: 27.99)

Item.create!(name: "Bottle of perfume",
             basic_tax: true,
             duty: false,
             price: 18.99)

Item.create!(name: "Packet of headache pills",
             basic_tax: false,
             duty: false,
             price: 9.75)

Item.create!(name: "Box of imported chocolates",
             basic_tax: false,
             duty: true,
             price: 11.25)
