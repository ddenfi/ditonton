import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:dartz/dartz.dart';

import '../../repositories/tv_series_repository.dart';

class GetPopularTvSeries {
  final TvSeriesRepositories repo;

  GetPopularTvSeries(this.repo);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repo.getPopularShow();
  }
}
