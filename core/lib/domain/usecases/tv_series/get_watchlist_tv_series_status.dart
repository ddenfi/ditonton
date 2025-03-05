import 'package:core/domain/repositories/tv_series_repository.dart';

class GetWatchlistTvSeriesStatus {
  final TvSeriesRepositories _repo;

  GetWatchlistTvSeriesStatus(this._repo);

  Future<bool> execute(int id) {
    return _repo.isAddedToWatchlist(id);
  }
}
