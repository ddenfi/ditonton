import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tv_series_watchlist_status_state.dart';

class TvSeriesWatchlistStatusCubit extends Cubit<TvSeriesWatchlistStatusState> {
  final GetWatchlistTvSeriesStatus getWatchlistTvSeriesStatus;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  String watchlistMessage = "";

  TvSeriesWatchlistStatusCubit(this.getWatchlistTvSeriesStatus,
      this.removeWatchlistTvSeries, this.saveWatchlistTvSeries)
      : super(TvSeriesWatchlistStatus(isAddedToWatchlist: false));

  Future<void> loadWatchlistStatus(int id) async {
    await getWatchlistTvSeriesStatus.execute(id).then((res) {
      emit(TvSeriesWatchlistStatus(isAddedToWatchlist: res));
    });
  }

  Future<void> addWatchlist(TvSeriesDetail show) async {
    final result = await saveWatchlistTvSeries.execute(show);

    result.fold((failure) {
      watchlistMessage = failure.message;
    }, (successMessage) {
      watchlistMessage = successMessage;
    });
    await loadWatchlistStatus(show.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail show) async {
    final result = await removeWatchlistTvSeries.execute(show);

    result.fold((failure) {
      watchlistMessage = failure.message;
    }, (successMessage) {
      watchlistMessage = successMessage;
    });
    await loadWatchlistStatus(show.id);
  }
}
