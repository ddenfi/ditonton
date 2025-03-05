import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_series/tv_series_detail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

class GetTvSeriesDetail {
  final TvSeriesRepositories repo;

  GetTvSeriesDetail(this.repo);

  Future<Either<Failure, TvSeriesDetail>> execute(int id) async {
    return repo.getShowDetail(id);
  }
}
