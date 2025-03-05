part of 'tv_series_top_rated_cubit.dart';

sealed class TvSeriesTopRatedState extends Equatable {
  const TvSeriesTopRatedState();
}

final class TvSeriesTopRatedInitial extends TvSeriesTopRatedState {
  @override
  List<Object> get props => [];
}

final class TvSeriesTopRatedStateLoading extends TvSeriesTopRatedState {
  @override
  List<Object?> get props => [];
}

final class TvSeriesTopRatedStateError extends TvSeriesTopRatedState {
  final String message;

  TvSeriesTopRatedStateError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class TvSeriesTopRatedStateSuccess extends TvSeriesTopRatedState {
  final List<TvSeries> data;

  TvSeriesTopRatedStateSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}
