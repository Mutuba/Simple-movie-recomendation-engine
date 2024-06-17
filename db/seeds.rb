# /db/seeds.rb
require "faker"
Faker::UniqueGenerator.clear
User.destroy_all
Movie.destroy_all
# using faker gem to create unique names to create users
30.times { User.create!(name: Faker::Name.unique.name) }
# 15 movies

  movies = [
    "Avengers: Infinity War",
    "Star Wars: The Force Awakens",
    "Avatar",
    "Titanic",
    "Jurassic World",
    "Black Panther",
    "Marvel’s The Avengers",
    "Star Wars: The Last Jedi",
    "The Dark Knight",
    "Beauty and the Beast",
    "Finding Dory",
    "Pirates of the Caribbean: Dead Man’s Chest",
    "Toy Story 3",
    "Wonder Woman",
    "Iron Man 3"
  ]
  
# create movies
i = 0
15.times do
  Movie.create(name: movies[i])
  i += 1
end
# randomly associate movies with users, where no user has the same movie more than once
100.times do
  user = User.all[rand(0...30)]
  movie = Movie.all[rand(0...15)]
  if user.movies.include?(movie)
    next
  else
    user.movies << movie
  end
end