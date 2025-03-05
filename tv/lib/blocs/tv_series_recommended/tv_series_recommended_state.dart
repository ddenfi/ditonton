part of 'tv_series_recommended_cubit.dart';

sealed class TvSeriesRecommendedState extends Equatable {
  const TvSeriesRecommendedState();
}

final class TvSeriesRecommendedInitial extends TvSeriesRecommendedState {
  @override
  List<Object> get props => [];
}

final class TvSeriesRecommendedStateLoading extends TvSeriesRecommendedState {
  @override
  List<Object?> get props => [];
}

final class TvSeriesRecommendedStateError extends TvSeriesRecommendedState {
  final String message;

  const TvSeriesRecommendedStateError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class TvSeriesRecommendedStateSuccess extends TvSeriesRecommendedState {
  final List<TvSeries> data;

  const TvSeriesRecommendedStateSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}
