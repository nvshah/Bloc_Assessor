part of 'movie_bloc.dart';

@immutable
abstract class MovieState {
  const MovieState(); // Need this inorder to support const constructore of Child classes to allow them to call parent constructor.
}

//No action has yet been taken by the user & We should display this at initial UI
class MovieInitial extends MovieState {
  const MovieInitial();
}

class MovieLoading extends MovieState {
  const MovieLoading();
}

class MovieLoaded extends MovieState {
  final Movie movie;
  const MovieLoaded(this.movie);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MovieLoaded && o.movie == movie;
  }

  @override
  int get hashCode => movie.hashCode;
}

class MovieError extends MovieState {
  final String message;
  const MovieError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MovieError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
