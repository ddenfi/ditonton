import 'package:core/core.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';

part 'movie_watchlist_status_state.dart';

class MovieWatchlistStatusCubit extends Cubit<MovieWatchlistStatusState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  String watchlistMessage = "";

  MovieWatchlistStatusCubit(
      this.getWatchListStatus, this.saveWatchlist, this.removeWatchlist)
      : super(MovieWatchlistStatus(isAddedToWatchlist: false));

  Future<void> loadWatchlistStatus(int id) async {
    await getWatchListStatus.execute(id).then((res) {
      emit(MovieWatchlistStatus(isAddedToWatchlist: res));
    });
  }

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);

    result.fold((failure) async {
      watchlistMessage = failure.message;
    }, (successMessage) async {
      watchlistMessage = successMessage;
    });
    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);

    result.fold((failure) async {
      watchlistMessage = failure.message;
    }, (successMessage) async {
      watchlistMessage = successMessage;
    });

    await loadWatchlistStatus(movie.id);
  }
}
