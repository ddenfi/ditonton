import 'package:core/common/exception.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/tv_series/tv_series_table.dart';

abstract class TvSeriesLocalDataSource {
  Future<String> insertWatchlist(TvSeriesTable show);

  Future<String> removeWatchlist(TvSeriesTable show);

  Future<TvSeriesTable?> getShowById(int id);

  Future<List<TvSeriesTable>> getWatchlistShows();
}

class TvSeriesLocalDataSourceImpl extends TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TvSeriesTable?> getShowById(int id) async {
    final result = await databaseHelper.getShowById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistShows() async {
    final result = await databaseHelper.getWatchlistShows();
    return result
        .map((data) => TvSeriesTable.fromMap(data))
        .where((tvSeries) => tvSeries.showType == "tv-series")
        .toList();
  }

  @override
  Future<String> insertWatchlist(TvSeriesTable show) async {
    try {
      await databaseHelper.insertWatchlist(show);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvSeriesTable show) async {
    try {
      await databaseHelper.removeWatchlist(show);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
