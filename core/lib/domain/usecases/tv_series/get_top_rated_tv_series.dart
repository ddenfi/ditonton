import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedTvSeries {
  final TvSeriesRepositories repo;

  GetTopRatedTvSeries(this.repo);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repo.getTopRatedShow();
  }
}
