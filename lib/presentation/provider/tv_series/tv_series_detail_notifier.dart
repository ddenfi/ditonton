import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series_status.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;
  final GetWatchlistTvSeriesStatus getWatchlistTvSeriesStatus;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvSeriesDetailNotifier(
      {required this.saveWatchlistTvSeries,
      required this.getTvSeriesRecommendations,
      required this.removeWatchlistTvSeries,
      required this.getWatchlistTvSeriesStatus,
      required this.getTvSeriesDetail});

  late TvSeriesDetail _show;

  TvSeriesDetail get show => _show;

  RequestState _showState = RequestState.Empty;

  RequestState get showState => _showState;

  List<TvSeries> _showRecommendations = [];

  List<TvSeries> get showRecommendations => _showRecommendations;

  RequestState _recommendationState = RequestState.Empty;

  RequestState get recommendationState => _recommendationState;

  String _message = '';

  String get message => _message;

  bool _isAddedtoWatchlist = false;

  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvSeriesDetail(int id) async {
    _showState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _showState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movie) {
        _recommendationState = RequestState.Loading;
        _show = movie;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (shows) {
            _recommendationState = RequestState.Loaded;
            _showRecommendations = shows;
          },
        );
        _showState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';

  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvSeriesDetail show) async {
    final result = await saveWatchlistTvSeries.execute(show);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(show.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail show) async {
    final result = await removeWatchlistTvSeries.execute(show);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(show.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchlistTvSeriesStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
