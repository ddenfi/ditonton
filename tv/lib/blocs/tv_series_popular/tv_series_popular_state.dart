part of 'tv_series_popular_cubit.dart';

sealed class TvSeriesPopularState extends Equatable {
  const TvSeriesPopularState();
}

final class TvSeriesPopularInitial extends TvSeriesPopularState {
  @override
  List<Object> get props => [];
}

final class TvSeriesPopularStateLoading extends TvSeriesPopularState {
  @override
  List<Object?> get props => [];
}

final class TvSeriesPopularStateError extends TvSeriesPopularState {
  final String message;

  const TvSeriesPopularStateError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class TvSeriesPopularStateSuccess extends TvSeriesPopularState {
  final List<TvSeries> data;

  const TvSeriesPopularStateSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}
