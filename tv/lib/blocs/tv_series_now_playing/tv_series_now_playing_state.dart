part of 'tv_series_now_playing_cubit.dart';

sealed class TvSeriesNowPlayingState extends Equatable {
  const TvSeriesNowPlayingState();
}

final class TvSeriesNowPlayingInitial extends TvSeriesNowPlayingState {
  @override
  List<Object> get props => [];
}

final class TvSeriesNowPlayingStateLoading extends TvSeriesNowPlayingState {
  @override
  List<Object?> get props => [];
}

final class TvSeriesNowPlayingStateError extends TvSeriesNowPlayingState {
  final String message;

  const TvSeriesNowPlayingStateError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class TvSeriesNowPlayingStateSuccess extends TvSeriesNowPlayingState {
  final List<TvSeries> data;

  const TvSeriesNowPlayingStateSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}
