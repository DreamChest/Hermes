# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'admin@foobar.com', password: 'admin', password_confirmation: 'admin')

source1 = Source.create(name: 'Korben', url: 'https://korben.info/feed')
source2 = Source.create(name: 'Slashdot', url: 'http://rss.slashdot.org/Slashdot/slashdotMain')
source3 = Source.create(name: 'Atom Packages', url: 'https://atom.io/packages.atom')
source1.tag(%w[tech blog])
source2.tag(['tech'])
source3.tag(['tech'])
