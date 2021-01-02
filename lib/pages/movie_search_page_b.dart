import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_bloc.dart';
import '../data/models/movie.dart';

class MovieSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Search Page'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        //We can't show Error i.e Snackbar during widget build
        //child: BlocBuilder<MovieCubit, MovieState>(
        child: BlocConsumer<MovieBloc, MovieState>(
          listener: (context, state) {
            //We need to show side effects under listener
            if (state is MovieError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is MovieInitial) {
              return buildInitialInput();
            } else if (state is MovieLoading) {
              return buildLoading();
            } else if (state is MovieLoaded) {
              return buildColumnWithData(state.movie);
            } else {
              //(state is MovieError)
              return buildInitialInput();
            }
          },
        ),
      ),
    );
  }

  ///initial input field to get the movie name
  Widget buildInitialInput() {
    return Center(
      child: InputField(),
    );
  }

  ///build the loading indicator
  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  ///build the UI - that shows movie name & ratings, given movie name
  Column buildColumnWithData(Movie movie) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        //MOVIE NAME
        Text(
          movie.name,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        //RATINGS
        Text(
          // Display the ratings with 1 decimal place
          "${movie.ratings.toStringAsFixed(1)} <--#",
          style: TextStyle(fontSize: 80),
        ),
        InputField(),
      ],
    );
  }
}

class InputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  //submit name to get ratings for the same
  void submitName(BuildContext context, String name) {
    // TODO: Get ratings for the movies
    final movieBloc = context
        .bloc<MovieBloc>(); //new elegant bloc extension on BuildContext class
    //final movieBloc = BlocProvider.of<MovieBloc>(context);
    //Add event to get weather
    movieBloc.add(GetMovie(name));
  }
}
