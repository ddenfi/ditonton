import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class SearchTvSeries {
  final TvSeriesRepositories _repo;

  SearchTvSeries(this._repo);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return _repo.searchShow(query);
  }
}
