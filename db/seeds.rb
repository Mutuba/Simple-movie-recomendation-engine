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



# given three tables, FriendDetails, PackageDetails and StudentDetails, with details as follows

# StudentDetails

# StudentId  StudentName


# FriendDetails

# StudentId  FriendId

# PackageDetails

# StudentId   Package

# SELECT sd.StudentId AS StudentId, sd.StudentName AS StudentName, fd.FriendId AS FriendId, sf.StudentName AS FriendName FROM StudentDetails sd JOIN FriendDetails fd ON sd.StudentId = fd.StudentId JOIN StudentDetails sf ON sf.StudentId = fd.FrindId JOIN PackageDetails sp ON sp.StudentId = sd.StudentId JOIN PackageDetails fp ON fp.StudentId = fd.FriendId Where fp.Package > sp.Package 

# Offer Query
# SELECT
#     sd.StudentId AS StudentId,
#     sd.StudentName AS StudentName,
#     fd.FriendId AS FriendId,
#     sf.StudentName AS FriendName
# FROM
#     StudentDetails sd
# JOIN
#     FriendDetails fd ON sd.StudentId = fd.StudentId
# JOIN
#     StudentDetails sf ON fd.FriendId = sf.StudentId
# JOIN
#     PackageDetails sp ON sd.StudentId = sp.StudentId
# JOIN
#     PackageDetails fp ON fd.FriendId = fp.StudentId
# WHERE
#     fp.Package > sp.Package;

# Salaries ranking
# WITH RankedSalaries AS (
#   SELECT 
#       employee_id, 
#       department_id, 
#       salary,
#       ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rn
#   FROM 
#       employees
# )
# SELECT 
#   employee_id, 
#   department_id, 
#   salary
# FROM 
#   RankedSalaries
# WHERE 
#   rn <= 5
# ORDER BY 
#   department_id, 
#   salary DESC;


# WITH Months AS (
#   SELECT 1 AS month_number UNION
#   SELECT 2 UNION
#   SELECT 3 UNION
#   SELECT 4 UNION
#   SELECT 5 UNION
#   SELECT 6 UNION
#   SELECT 7 UNION
#   SELECT 8 UNION
#   SELECT 9 UNION
#   SELECT 10 UNION
#   SELECT 11 UNION
#   SELECT 12
# ), MonthlySales AS (
#   SELECT 
#     EXTRACT(MONTH FROM sales_date) AS month_number,
#     SUM(sales_amount) AS total_sales
#   FROM 
#     sales
#   WHERE 
#     EXTRACT(YEAR FROM sales_date) = EXTRACT(YEAR FROM CURRENT_DATE)
#   GROUP BY 
#     EXTRACT(MONTH FROM sales_date)
# )
# SELECT 
#   m.month_number,
#   COALESCE(ms.total_sales, 0) AS total_sales
# FROM 
#   Months m
# LEFT JOIN 
#   MonthlySales ms 
# ON 
#   m.month_number = ms.month_number
# ORDER BY 
#   m.month_number;


# Products sold across all cities of operations
# SELECT p.product_name
# FROM products p
# JOIN sales s ON p.product_id = s.product_id
# JOIN cities c ON s.city_id = c.city_id
# GROUP BY p.product_id, p.product_name
# HAVING COUNT(DISTINCT c.city_id) = (SELECT COUNT(*) FROM cities);
