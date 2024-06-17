# README

# **Collaborative filtering**

What is collaborative filtering?

- Let’s say Person A likes Movie A, B, C
- There are other people who also like Movie A, B, C
- Those other people also like other movies that Person A doesn’t know/hasn’t watched
- Since Person A and other people share the same likes of Movie A, B, C, chances are they have a very similar taste in movies, so Person A may also want to know/watch those other movies other people liked

Now we have a better understanding on how recommendation engines work. To implement collaborative filtering in code, there are many ways, from basic to advanced. The algorithm we’ll use is:

1.  For every one other user, find the movies both him/her and Person A like
2.  Calculate the number of liked movies Person A and him/her share. The more movies Person A share with another user, the more weight we will put to his/her recommendation.
3.  The weight is calculated by dividing the total number of shared movies by the total number of all movies the other user liked.
4.  The reason we do in this way is that we can rule out the noise and edge cases, where a user may have simply liked all or almost all movies for no reason.
5.  If we don’t do in this way, should the above case happen, it will recommend everything with too much of a weight and pollute our score.
6.  Associate each movie with its own weight in a hash. When different users liked a same movie, we accumulate the weight for that movie.
7.  As you can see, the most recommended movie will have the highest weight (recommendation rating)!
8.  Sort the hash by the weights in descending order and we are done!

# Running the App

This application uses Ruby version 3.2.2 To install, use rvm or rbenv.

RVM

`rvm install 3.2.2`

`rvm use 3.2.2`

- Rbenv

`rbenv install 3.2.2`

Bundler provides a consistent environment for Ruby projects by tracking and installing  
the exact gems and versions that are needed. I recommend bundler version 2.0.2. To install:

You need Rails. The rails version being used is rails version 7

To install:

`gem install rails -v '~> 7'`

\*To get up and running with the project locally, follow the following steps.

Clone the app

With SSH

`git@github.com:Mutuba/Simple-movie-recomendation-engine.git`

- With HTTPS

`https://github.com/Mutuba/Simple-movie-recomendation-engine.git`

Move into the directory and install all the requirements.

cd rails_url_shortener_app

run `bundle install` to install application packages

Run `rails db:create` to create a database for the application

Run `rails db:migrate` to run database migrations and create database tables

Run `rails db:seed` to seed the database with sample test data

The application can be run by running the below command:-

`rails s` or `rails server`

See the app live!
