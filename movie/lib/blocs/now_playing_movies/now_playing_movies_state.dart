part of 'now_playing_movies_cubit.dart';

sealed class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();
}

final class NowPlayingMoviesInitial extends NowPlayingMoviesState {
  @override
  List<Object> get props => [];
}

final class NowPlayingMoviesLoading extends NowPlayingMoviesState {
  @override
  List<Object?> get props => [];
}

final class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;

  NowPlayingMoviesError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class NowPlayingMoviesSuccess extends NowPlayingMoviesState {
  final List<Movie> data;

  NowPlayingMoviesSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}
