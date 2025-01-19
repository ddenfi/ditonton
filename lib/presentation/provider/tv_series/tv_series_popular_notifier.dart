import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:flutter/foundation.dart';

class TvSeriesPopularNotifier extends ChangeNotifier {
  final GetPopularTvSeries getPopularTvSeries;

  TvSeriesPopularNotifier({required this.getPopularTvSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _shows = [];
  List<TvSeries> get shows => _shows;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (show) {
        _shows = show;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
