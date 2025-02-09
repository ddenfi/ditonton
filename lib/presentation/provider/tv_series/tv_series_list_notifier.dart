import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:flutter/material.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  var _nowPlayingShows = <TvSeries>[];

  List<TvSeries> get nowPlayingShows => _nowPlayingShows;

  RequestState _nowPlayingState = RequestState.Empty;

  RequestState get nowPlayingState => _nowPlayingState;

  var _popularShows = <TvSeries>[];

  List<TvSeries> get popularShows => _popularShows;

  RequestState _popularMoviesState = RequestState.Empty;

  RequestState get popularTvSeriesState => _popularMoviesState;

  var _topRatedShows = <TvSeries>[];

  List<TvSeries> get topRatedShows => _topRatedShows;

  RequestState _topRatedMoviesState = RequestState.Empty;

  RequestState get topRatedTvSeriesState => _topRatedMoviesState;

  String _message = '';

  String get message => _message;

  TvSeriesListNotifier({
    required this.getNowPlayingShows,
    required this.getPopularShows,
    required this.getTopRatedShows,
  });

  final GetNowPlayingTvSeries getNowPlayingShows;
  final GetPopularTvSeries getPopularShows;
  final GetTopRatedTvSeries getTopRatedShows;

  Future<void> fetchNowPlayingShow() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingShows.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingShows = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularShow() async {
    _popularMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularShows.execute();
    result.fold(
      (failure) {
        _popularMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _popularMoviesState = RequestState.Loaded;
        _popularShows = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedShow() async {
    _topRatedMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedShows.execute();
    result.fold(
      (failure) {
        _topRatedMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _topRatedMoviesState = RequestState.Loaded;
        _topRatedShows = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
