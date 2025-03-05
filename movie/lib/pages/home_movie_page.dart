import 'package:core/common/constants.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:movie/blocs/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movie/blocs/popular_movies/popular_movies_cubit.dart';
import 'package:movie/blocs/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movie/pages/popular_movies_page.dart';
import 'package:movie/pages/top_rated_movies_page.dart';

import 'movie_detail_page.dart';

class HomeMoviePage extends StatefulWidget {
  static const String ROUTE_NAME = "/home";

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMoviesCubit>().fetchNowPlayingMovies();
      context.read<PopularMoviesCubit>().fetchPopularMovies();
      context.read<TopRatedMoviesCubit>().fetchTopRatedMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesState>(
                builder: (context, state) {
                  switch (state) {
                    case NowPlayingMoviesLoading():
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case NowPlayingMoviesError():
                      return Text(state.message);
                    case NowPlayingMoviesSuccess():
                      return MovieList(state.data);
                    case NowPlayingMoviesInitial():
                      return SizedBox();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
                builder: (context, state) {
                  switch (state) {
                    case PopularMoviesInitial():
                      return SizedBox();
                    case PopularMoviesLoading():
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case PopularMoviesError():
                      return Text(state.message);
                    case PopularMoviesSuccess():
                      return MovieList(state.data);
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedMoviesCubit, TopRatedMoviesState>(
                builder: (context, state) {
                  switch (state) {
                    case TopRatedMoviesInitial():
                      return SizedBox();
                    case TopRatedMoviesLoading():
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case TopRatedMoviesError():
                      return Text(state.message);
                    case TopRatedMoviesSuccess():
                      return MovieList(state.data);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
