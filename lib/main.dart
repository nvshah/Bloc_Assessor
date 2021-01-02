import 'package:cubit_bloc_assessor/bloc/movie_bloc.dart';
import 'package:cubit_bloc_assessor/cubit/movie_cubit.dart';
import 'package:cubit_bloc_assessor/data/movie_repository.dart';
import 'package:flutter/material.dart';

import 'package:cubit_bloc_assessor/pages/movie_search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './pages/movie_search_page_b.dart' as blocMovie;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final useCubit = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieRating App',
      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
      //We need to inject the BlocProvider we want to access down the levels
      home: !useCubit
          ? BlocProvider(
              //FOR BLOC
              create: (context) => MovieBloc(FakeRatingsRepository()),
              child: blocMovie.MovieSearchPage())
          : BlocProvider(
              //FOR CUBIT
              create: (context) => MovieCubit(FakeRatingsRepository()),
              child: MovieSearchPage()),
    );
  }
}
