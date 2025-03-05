part of 'movie_watchlist_status_cubit.dart';

sealed class MovieWatchlistStatusState extends Equatable {
  final bool isAddedToWatchlist;

  const MovieWatchlistStatusState({required this.isAddedToWatchlist});
}

final class MovieWatchlistStatus extends MovieWatchlistStatusState {
  const MovieWatchlistStatus({
    required super.isAddedToWatchlist,
  });

  @override
  List<Object?> get props => [isAddedToWatchlist];
}
