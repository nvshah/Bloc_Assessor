import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/movie.dart';
import '../data/movie_repository.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository _movieRepository;

  MovieCubit(this._movieRepository) : super(MovieInitial());
  

  ///get the movie-model containing ratings given movie name
  Future<void> getMovie(String name) async{
    try{
      //show loading until ratings is fetched
      emit(MovieLoading());
      //fetch the ratings from repositiory
      final movie = await _movieRepository.fetchRatings(name);
      //signal completion of fetching (i.e either success or error)
      emit(MovieLoaded(movie));
    }on NetworkException{
      emit(MovieError("Couldn't fetch weather. Is the device online?"));
    }
  }
}
