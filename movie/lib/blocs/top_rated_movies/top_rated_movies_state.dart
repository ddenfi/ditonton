part of 'top_rated_movies_cubit.dart';

sealed class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();
}

final class TopRatedMoviesInitial extends TopRatedMoviesState {
  @override
  List<Object> get props => [];
}

final class TopRatedMoviesLoading extends TopRatedMoviesState {
  @override
  List<Object?> get props => [];
}

final class TopRatedMoviesError extends TopRatedMoviesState {
  final String message;

  const TopRatedMoviesError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class TopRatedMoviesSuccess extends TopRatedMoviesState {
  final List<Movie> data;

  const TopRatedMoviesSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}
