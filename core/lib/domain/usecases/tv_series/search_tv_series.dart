import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

class SearchTvSeries {
  final TvSeriesRepositories _repo;

  SearchTvSeries(this._repo);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return _repo.searchShow(query);
  }
}
