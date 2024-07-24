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

# SELECT sd.StudentId AS StudentId, sd.StudentName AS StudentName, fd.FriendId AS FriendId, sf.StudentName AS FriendName 
# FROM StudentDetails sd JOIN FriendDetails fd 
# ON sd.StudentId = fd.StudentId JOIN StudentDetails sf ON sf.StudentId = fd.FriendId 
# JOIN PackageDetails sp ON sp.StudentId = sd.StudentId JOIN PackageDetails fp ON fp.StudentId = fd.FriendId Where fp.Package > sp.Package 

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
#     StudentDetails sf sf.StudentId = ON fd.FriendId
# JOIN
#     PackageDetails sp ON sd.StudentId = sp.StudentId
# JOIN
#     PackageDetails fp ON fp.StudentId = fd.FriendId
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
# ), MonthlySalesForLast12 AS (
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
#   MonthlySalesForLast12 ms 
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

# Employees earning more than department average

# WITH departmentAverage AS (
#   SELECT department_id, AVG(salary) AS department_average
#   FROM employees
#   GROUP BY department_id
# )

# SELECT e.name, e.department_id
# FROM employees e
# INNER JOIN departmentAverage da ON e.department_id = da.department_id
# WHERE e.salary > da.department_average;


# Pivot table examples
# SELECT
#     ProductCategory,
#     SUM(CASE WHEN Month = 'January' THEN SalesAmount ELSE 0 END) AS January,
#     SUM(CASE WHEN Month = 'February' THEN SalesAmount ELSE 0 END) AS February,
#     SUM(CASE WHEN Month = 'March' THEN SalesAmount ELSE 0 END) AS March
# FROM
#     SalesData
# GROUP BY
#     ProductCategory;


# SELECT
#     Month,
#     SUM(CASE WHEN ProductCategory = 'Electronics' THEN SalesAmount ELSE 0 END) AS Electronics,
#     SUM(CASE WHEN ProductCategory = 'Clothing' THEN SalesAmount ELSE 0 END) AS Clothing,
#     ... -- Add more categories as needed
# FROM
#     SalesData
# GROUP BY
#     Month;


# Department with highest average salary for employees with atleast 2 years
# SELECT department_id, AVG(salary) AS average_salary
# FROM employees
# WHERE hire_date <= DATE_SUB(CURRENT_DATE, INTERVAL 2 YEAR)
# GROUP BY department_id
# ORDER BY average_salary DESC
# LIMIT 1;


# Moving Average

# SELECT 
#     date, 
#     price, 
#     AVG(price) OVER (ORDER BY date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
# FROM 
#     stock_prices;

# Ranked Orders

# WITH RankedOrders AS (
#   SELECT
#     customer_id,
#     order_id,
#     order_date,
#     ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS order_rank
#   FROM
#     orders
# )

# SELECT
#   customer_id,
#   order_id,
#   order_date
# FROM
#   RankedOrders
# WHERE
#   order_rank <= 3
# ORDER BY
#   customer_id,
#   order_date DESC;


# WITH EmployeeCount AS (
# SELECT e.manager_id, COUNT(*) as employee_count FROM employees e group by manager_id
#)

# Employees earning more than their manager
# SELECT employee.id employee.salary, manager.id, manager.salary 
# FROM employees employee JOIN Employees manager on employee.manager_id = manager.id 
# WHERE employee.salary > manager.salary

# Employee managing samme number of employees as manager
# SELECT employee.name from employees employee 
# JOIN EmployeeCount ec on employee.id = ec.manager_id 
# JOIN EmployeeCount ec2 on employee.manager_id = ec2.manager_id
# where ec.employee_count =  ec2.employee_count


# Trips:
# +------+-----------+-----------+---------+---------------------+------------+
# | id   | client_id | driver_id | city_id | status              | request_at |
# +------+-----------+-----------+---------+---------------------+------------+
# |    1 |         1 |        10 |       1 | completed           | 2023-07-12 |
# |    2 |         2 |        11 |       1 | cancelled_by_driver | 2023-07-12 |
# |    3 |         3 |        12 |       6 | completed           | 2023-07-12 |
# |    4 |         4 |        13 |       6 | cancelled_by_client | 2023-07-12 |
# |    5 |         1 |        10 |       1 | completed           | 2023-07-13 |
# |    6 |         2 |        11 |       6 | completed           | 2023-07-13 |
# |    7 |         3 |        12 |       6 | completed           | 2023-07-13 |
# |    8 |         2 |        12 |      12 | completed           | 2023-07-14 |
# |    9 |         3 |        10 |      12 | completed           | 2023-07-14 |
# |   10 |         4 |        13 |      12 | cancelled_by_driver | 2023-07-14 |
# +------+-----------+-----------+---------+---------------------+------------+

# Users:
# +----------+--------+--------+
# | users_id | banned | role   |
# +----------+--------+--------+
# |        1 | No     | client |
# |        2 | Yes    | client |
# |        3 | No     | client |
# |        4 | No     | client |
# |       10 | No     | driver |
# |       11 | No     | driver |
# |       12 | No     | driver |
# |       13 | No     | driver |
# +----------+--------+--------+

# CREATE TABLE Trips (
#   id INT,
#   client_id INT,
#   driver_id INT,
#   city_id INT,
#   status VARCHAR(20),
#   request_at DATE
# );

# INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES
#   (1, 1, 10, 1, 'completed', '2023-07-12'),
#   (2, 2, 11, 1, 'cancelled_by_driver', '2023-07-12'),
#   (3, 3, 12, 6, 'completed', '2023-07-12'),
#   (4, 4, 13, 6, 'cancelled_by_client', '2023-07-12'),
#   (5, 1, 10, 1, 'completed', '2023-07-13'),
#   (6, 2, 11, 6, 'completed', '2023-07-13'),
#   (7, 3, 12, 6, 'completed', '2023-07-13'),
#   (8, 2, 12, 12, 'completed', '2023-07-14'),
#   (9, 3, 10, 12, 'completed', '2023-07-14'),
#   (10, 4, 13, 12, 'cancelled_by_driver', '2023-07-14');

# CREATE TABLE Users (
#   users_id INT,
#   banned VARCHAR(3),
#   role VARCHAR(10)
# );

# INSERT INTO Users (users_id, banned, role) VALUES
#   (1, 'No', 'client'),
#   (2, 'Yes', 'client'),
#   (3, 'No', 'client'),
#   (4, 'No', 'client'),
#   (10, 'No', 'driver'),
#   (11, 'No', 'driver'),
#   (12, 'No', 'driver'),
#   (13, 'No', 'driver');


#   WITH UnbannedTrips AS (
#     SELECT
#         t.request_at AS Day,
#         COUNT(CASE WHEN t.status LIKE 'cancelled%' THEN 1 END) AS canceled_requests,
#         COUNT(*) AS total_requests
#     FROM
#         Trips t
#         JOIN Users u1 ON t.client_id = u1.users_id
#         JOIN Users u2 ON t.driver_id = u2.users_id
#     WHERE
#         u1.banned = 'No' AND u2.banned = 'No'
#     GROUP BY
#         t.request_at
# )
# SELECT
#     Day,
#     ROUND(canceled_requests / NULLIF(total_requests, 0), 2) AS `Cancellation Rate`
# FROM
#     UnbannedTrips
# ORDER BY
#     Day;


#     +------------+-------------------+
#     | Day        | Cancellation Rate |
#     +------------+-------------------+
#     | 2023-07-12 |              0.33 |
#     | 2023-07-13 |              0.00 |
#     | 2023-07-14 |              0.50 |
#     +------------+-------------------+
#     3 rows in set (0.01 sec