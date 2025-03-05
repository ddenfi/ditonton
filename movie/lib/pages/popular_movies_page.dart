import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/blocs/popular_movies/popular_movies_cubit.dart';
import 'package:movie/widgets/movie_card_list.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  const PopularMoviesPage({super.key});

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularMoviesCubit>().fetchPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
          builder: (context, state) {
            switch (state) {
              case PopularMoviesInitial():
                return SizedBox();
              case PopularMoviesLoading():
                return Center(
                  child: CircularProgressIndicator(),
                );

              case PopularMoviesError():
                return Center(
                  key: Key('error_message'),
                  child: Text(state.message),
                );

              case PopularMoviesSuccess():
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.data[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.data.length,
                );
            }
          },
        ),
      ),
    );
  }
}
