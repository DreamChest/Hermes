# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

source1 = Source.create(name: 'Korben', url: 'https://korben.info/feed')
content1 = Content.new(html: '...')
article1 = Article.new(title: 'article1', date: Time.now, url: '...', content: content1)
tag1 = Tag.create(name: 'tag1', color: '#ffffff')
source1.articles << article1
source1.tags << tag1
