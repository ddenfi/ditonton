import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/blocs/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movie/widgets/movie_card_list.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  const TopRatedMoviesPage({super.key});

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedMoviesCubit>().fetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
          builder: (context, state) {
            switch (state) {
              case TopRatedMoviesInitial():
                return SizedBox();
              case TopRatedMoviesLoading():
                return Center(
                  child: CircularProgressIndicator(),
                );

              case TopRatedMoviesError():
                return Center(
                  key: Key('error_message'),
                  child: Text(state.message),
                );

              case TopRatedMoviesSuccess():
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
