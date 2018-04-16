# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(email: 'admin@foobar.com', password: 'admin', password_confirmation: 'admin')
user2 = User.create(email: 'user@foobar.com', password: 'user', password_confirmation: 'user')

source1 = Source.new(name: 'Korben', url: 'https://korben.info/feed')
source2 = Source.new(name: 'Slashdot', url: 'http://rss.slashdot.org/Slashdot/slashdotMain')
source3 = Source.new(name: 'Atom Packages', url: 'https://atom.io/packages.atom')

user1.sources << source1
user1.sources << source2
user2.sources << source3

source1.tag(%w[tech blog])
source2.tag(['tech'])
source3.tag(['tech'])
