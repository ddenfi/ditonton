part of 'search_movies_cubit.dart';

sealed class SearchMoviesState extends Equatable {
  const SearchMoviesState();
}

final class SearchMoviesInitial extends SearchMoviesState {
  @override
  List<Object> get props => [];
}

final class SearchMoviesLoading extends SearchMoviesState {
  @override
  List<Object?> get props => [];
}

final class SearchMoviesError extends SearchMoviesState {
  final String message;

  const SearchMoviesError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class SearchMoviesSuccess extends SearchMoviesState {
  final List<Movie> data;

  const SearchMoviesSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}
