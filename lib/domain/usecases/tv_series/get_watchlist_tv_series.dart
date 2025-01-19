import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetWatchlistTvSeries{
  final TvSeriesRepositories _repo;

  GetWatchlistTvSeries(this._repo);

  Future<Either<Failure, List<TvSeries>>> execute(){
    return _repo.getWatchlistShow();
  }
}