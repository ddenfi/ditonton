import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_watchlist_state.dart';

class MovieWatchlistCubit extends Cubit<MovieWatchlistState> {
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatus getWatchListStatus;

  MovieWatchlistCubit(
      {required this.saveWatchlist,
      required this.removeWatchlist,
      required this.getWatchlistMovies,
      required this.getWatchListStatus})
      : super(MovieWatchlistInitial());

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);


    result.fold((failure) {
      // emit(MovieWatchlistDataState(isAddedToWatchlist: false));
    }, (data) {
      // emit(MovieWatchlistDataState(isAddedToWatchlist: true));
    });
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async{
    final result = await removeWatchlist.execute(movie);

    result.fold((failure){}, (data){});
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    // emit(MovieWatchlistDataState(isAddedToWatchlist: result));
  }
}
