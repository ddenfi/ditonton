import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';


class GetWatchlistTvSeries {
  final TvSeriesRepositories _repo;

  GetWatchlistTvSeries(this._repo);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return _repo.getWatchlistShow();
  }
}
