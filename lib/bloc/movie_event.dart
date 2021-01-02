part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {}

//Events are useful when we want to track them or we want to transform them esp using RxDart
class GetMovie extends MovieEvent {
  final String movieName;

  GetMovie(this.movieName);
}
