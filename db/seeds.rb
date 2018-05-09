# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create(email: 'admin@foobar.com', password: 'admin', password_confirmation: 'admin')
u2 = User.create(email: 'user@foobar.com', password: 'user', password_confirmation: 'user')

s1 = u1.sources.create(name: 'Korben', url: 'https://korben.info/feed')
s2 = u1.sources.create(name: 'Slashdot', url: 'http://rss.slashdot.org/Slashdot/slashdotMain')
s3 = u2.sources.create(name: 'Atom Packages', url: 'https://atom.io/packages.atom')

s1.tag(%w[tech blog])
# s2.tag(['tech'])
# s3.tag(['tech'])
