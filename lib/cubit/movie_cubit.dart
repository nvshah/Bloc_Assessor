import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/movie.dart';
import '../data/movie_repository.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository _movieRepository;

  MovieCubit(this._movieRepository) : super(MovieInitial());

  Future<void> getMovie(String name) async{
    try{
      emit(MovieLoading());
      final movie = await _movieRepository.fetchRatings(name);
      emit(MovieLoaded(movie));
    }on NetworkException{
      emit(MovieError("Couldn't fetch weather. Is the device online?"));
    }
  }
}
