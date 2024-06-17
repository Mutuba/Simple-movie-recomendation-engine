# README

**Collaborative filtering**

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
