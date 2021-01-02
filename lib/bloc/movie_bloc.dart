import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cubit_bloc_assessor/data/movie_repository.dart';
import 'package:meta/meta.dart';

import 'package:cubit_bloc_assessor/data/models/movie.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository _movieRepository;

  MovieBloc(this._movieRepository) : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is GetMovie) {
      try {
        yield MovieLoading();
        final movie = await _movieRepository.fetchRatings(event.movieName);
        yield MovieLoaded(movie);
      } on NetworkException {
        yield MovieError(
            "Could'nt fetch Movie Ratings. Is the device online ?");
      }
    }
  }
}
