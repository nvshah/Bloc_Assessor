import 'dart:math';

import './models/movie.dart';

abstract class MovieRepository {
  Future<Movie> fetchRatings(String name);
}

///Generate Fake ratings
class FakeRatingsRepository implements MovieRepository {
  double ratings;

  @override
  Future<Movie> fetchRatings(String name) {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();

        // Simulate some network error
        if (random.nextBool()) {
          throw NetworkException();
        }

        // Since we're inside a fake repository, we need to cache the ratings
        // in order to have the same one returned in for the detailed weather
        ratings = 3 + random.nextInt(6) + random.nextDouble();

        // Return "fetched" weather
        return Movie(
          name: name,
          // Temperature between 20 and 35.99
          ratings: ratings,
        );
      },
    );
  }
}

class NetworkException extends Error {}