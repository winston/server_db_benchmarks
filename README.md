# Server DB Benchmarks

Simple benchmark with various Server-DB combinations for retrieving one record:

1. Goliath, Grape with MongoDB, using em-mongo
2. Goliath, Grape with MongoDB, using mongoid
3. Goliath, Grape with MongoDB, using moped
4. Goliath, Grape with MySQL, using activerecord
5. Puma, Rails, Grape with MongoDB, using mongoid
6. Puma, Rails, Grape with MySQL, using activerecord

## Prequisite

To run the apps, you will need to have `MySQL` and `mongodb` installed.

    > brew install mysql
    > brew install mongodb

## Testing

Go into any of the app directory. Start the app.

    > foreman start

For each app, there are two endpoints:

    # This sets up test data. Use one of the records for the next endpoint.
    /posts/test

    # This retrieves one record from the database.
    /posts/:id

First, go to `<hostname:3000>/posts/test` to set up test data.

Pick one of the generated records and use the second endpoint for the benchmark.

I tested the app with:

    > ab -n 500 -c 200 <hostname:port>/posts/:id

This means 500 requests with 20 as the concurrency level.

## Results

Refer to the *.txt files for the results. The benchmark was ran on:

- iMac 3.2 GHz Intel Core i5 with 16 GB Ram
- Ruby 2.0.0 p 247
- MySQL 5.6.13
- mongodb 2.4.6
- ApacheBench, Version 2.3

On the surface, it seems like Puma, Rails, Grape with ActiveRecord performed the best,
and tuning the number of workers for the Puma server can improve the results even further.
