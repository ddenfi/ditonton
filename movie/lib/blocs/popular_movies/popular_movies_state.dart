part of 'popular_movies_cubit.dart';

sealed class PopularMoviesState extends Equatable {
  const PopularMoviesState();
}

final class PopularMoviesInitial extends PopularMoviesState {
  @override
  List<Object> get props => [];
}

final class PopularMoviesLoading extends PopularMoviesState {
  @override
  List<Object?> get props => [];
}

final class PopularMoviesError extends PopularMoviesState {
  final String message;

  const PopularMoviesError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class PopularMoviesSuccess extends PopularMoviesState {
  final List<Movie> data;

  const PopularMoviesSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}
