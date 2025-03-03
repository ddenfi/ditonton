import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_cubit.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MovieWatchlistCubit>().fetchWatchlistMovie());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<MovieWatchlistCubit>().fetchWatchlistMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<MovieWatchlistCubit, MovieWatchlistState>(
            builder: (context, state) {
              switch (state) {
                case MovieWatchlistInitial():
                  return SizedBox();
                case MovieWatchlistLoading():
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case MovieWatchlistError():
                  return Center(
                    key: Key('error_message'),
                    child: Text(state.message),
                  );
                case MovieWatchlistSuccess():
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      return MovieCard(movie);
                    },
                    itemCount: state.movies.length,
                  );
              }
            },
          )),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
