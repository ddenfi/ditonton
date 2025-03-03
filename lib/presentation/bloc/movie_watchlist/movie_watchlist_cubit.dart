import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_watchlist_state.dart';

class MovieWatchlistCubit extends Cubit<MovieWatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;

  MovieWatchlistCubit({
    required this.getWatchlistMovies,
  }) : super(MovieWatchlistInitial());

  Future<void> fetchWatchlistMovie() async {
    emit(MovieWatchlistLoading());

    await getWatchlistMovies.execute().then((res) {
      res.fold((failure) {
        emit(MovieWatchlistError(message: failure.message));
      }, (data) {
        emit(MovieWatchlistSuccess(movies: data));
      });
    });
  }
}
