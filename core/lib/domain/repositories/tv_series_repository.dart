import 'package:core/common/failure.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:core/domain/entities/tv_series/tv_series_detail.dart';
import 'package:dartz/dartz.dart';

abstract class TvSeriesRepositories {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingShow();

  Future<Either<Failure, List<TvSeries>>> getPopularShow();

  Future<Either<Failure, List<TvSeries>>> getTopRatedShow();

  Future<Either<Failure, TvSeriesDetail>> getShowDetail(int id);

  Future<Either<Failure, List<TvSeries>>> getShowRecommendations(int id);

  Future<Either<Failure, List<TvSeries>>> searchShow(String query);

  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail show);

  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail show);

  Future<bool> isAddedToWatchlist(int id);

  Future<Either<Failure, List<TvSeries>>> getWatchlistShow();
}
