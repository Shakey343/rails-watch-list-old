# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# puts 'Destroying old movies...'
# Movie.destroy_all

# puts 'Creating 5 fake movies...'
# 5.times do
#   movie = Movie.new(
#     title: Faker::Movie.title,
#     overview: Faker::Movie.quote,
#     poster_url: 'https://picsum.photos/200',
#     rating: rand(0..5)
#   )
#   movie.save!
# end
# puts 'Finished!'

require 'open-uri'
require 'json'
url = 'http://tmdb.lewagon.com/movie/top_rated'
url_serialized = URI.open(url).read
top_movies = JSON.parse(url_serialized)
i = 0
Movie.destroy_all
while i < 20
  puts 'Creating movie'
  base_poster_url = "https://image.tmdb.org/t/p/original"
  movie = Movie.new(
    title: top_movies['results'][i]['title'],
    overview: top_movies['results'][i]['overview'],
    poster_url: "#{base_poster_url}#{top_movies['results'][i]['poster_path']}",
    rating: top_movies['results'][i]['vote_average']
  )
  movie.save!
  puts "#{movie.title} was created!"
  i += 1
end
puts 'Finished'

# file = URI.open("https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/NES-Console-Set.jpg/1200px-NES-Console-Set.jpg")
# article = Article.new(title: "NES", body: "A great console")
# article.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
# article.save
