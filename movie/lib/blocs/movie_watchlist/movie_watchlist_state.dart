part of 'movie_watchlist_cubit.dart';

@immutable
sealed class MovieWatchlistState extends Equatable {}

final class MovieWatchlistInitial extends MovieWatchlistState {
  @override
  List<Object?> get props => [];
}

final class MovieWatchlistLoading extends MovieWatchlistState {
  @override
  List<Object?> get props => [];
}

final class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  MovieWatchlistError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class MovieWatchlistSuccess extends MovieWatchlistState {
  final List<Movie> movies;

  MovieWatchlistSuccess({required this.movies});

  @override
  List<Object?> get props => [movies];
}
