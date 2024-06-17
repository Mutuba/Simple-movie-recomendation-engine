module Recommendation
   def recommend_movies
     other_users = self.class.where.not(id: self.id)
     self_movies = self.movies.to_set
 
     recommended = other_users.reduce(Hash.new(0)) do |acc, user|
       user_movies = user.movies.to_set
       common_movies = user_movies & self_movies
       weight = common_movies.size.to_f / user_movies.size
       (user_movies - common_movies).each do |movie|
         acc[movie] += weight
       end
       acc
     end
 
     sorted_recommended = recommended.sort_by { |_, weight| weight }.reverse
   end
 end
 