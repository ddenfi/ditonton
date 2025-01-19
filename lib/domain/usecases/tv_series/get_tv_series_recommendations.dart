import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/repositories/tv_series_repository.dart';

class GetTvSeriesRecommendations {
  final TvSeriesRepositories repo;

  GetTvSeriesRecommendations(this.repo);

  Future<Either<Failure, List<TvSeries>>> execute(int id) {
    return repo.getShowRecommendations(id);
  }
}
