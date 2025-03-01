part of 'tv_series_search_cubit.dart';

@immutable
sealed class TvSeriesSearchState extends Equatable {}

final class TvSeriesSearchInitial extends TvSeriesSearchState {
  @override
  List<Object?> get props => [];
}

final class TvSeriesSearchStateLoading extends TvSeriesSearchState {
  @override
  List<Object?> get props => [];
}

final class TvSeriesSearchStateError extends TvSeriesSearchState {
  final String message;

  TvSeriesSearchStateError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class TvSeriesSearchStateSuccess extends TvSeriesSearchState {
  final List<TvSeries> data;

  TvSeriesSearchStateSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}
