part of 'tv_series_watchlist_status_cubit.dart';

@immutable
sealed class TvSeriesWatchlistStatusState extends Equatable {
  final bool isAddedToWatchlist;

  const TvSeriesWatchlistStatusState({required this.isAddedToWatchlist});
}

final class TvSeriesWatchlistStatus extends TvSeriesWatchlistStatusState {
  const TvSeriesWatchlistStatus({required super.isAddedToWatchlist});

  @override
  List<Object?> get props => [isAddedToWatchlist];
}
