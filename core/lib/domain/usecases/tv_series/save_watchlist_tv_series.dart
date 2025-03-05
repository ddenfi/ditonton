import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_series/tv_series_detail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';


class SaveWatchlistTvSeries {
  final TvSeriesRepositories _repo;

  SaveWatchlistTvSeries(this._repo);

  Future<Either<Failure, String>> execute(TvSeriesDetail show) {
    return _repo.saveWatchlist(show);
  }
}
