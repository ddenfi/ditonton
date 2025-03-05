part of 'tv_series_watchlist_cubit.dart';

sealed class TvSeriesWatchlistState extends Equatable {
  const TvSeriesWatchlistState();
}

final class TvSeriesWatchlistInitial extends TvSeriesWatchlistState {
  @override
  List<Object> get props => [];
}

final class TvSeriesWatchlistLoading extends TvSeriesWatchlistState {
  @override
  List<Object?> get props => [];
}

final class TvSeriesWatchlistError extends TvSeriesWatchlistState {
  final String message;

  const TvSeriesWatchlistError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class TvSeriesWatchlistSuccess extends TvSeriesWatchlistState {
  final List<TvSeries> tvSeries;

  const TvSeriesWatchlistSuccess({required this.tvSeries});

  @override
  List<Object?> get props => [tvSeries];
}
