part of 'tv_series_detail_cubit.dart';

sealed class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();
}

final class TvSeriesDetailInitial extends TvSeriesDetailState {
  @override
  List<Object> get props => [];
}

final class TvSeriesDetailStateLoading extends TvSeriesDetailState {
  @override
  List<Object?> get props => [];
}

final class TvSeriesDetailStateError extends TvSeriesDetailState {
  final String message;

  const TvSeriesDetailStateError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class TvSeriesDetailStateSuccess extends TvSeriesDetailState {
  final TvSeriesDetail data;

  const TvSeriesDetailStateSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}
