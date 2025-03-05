part of 'recommended_movies_cubit.dart';

sealed class RecommendedMoviesState extends Equatable {
  const RecommendedMoviesState();
}

final class RecommendedMoviesInitial extends RecommendedMoviesState {
  @override
  List<Object> get props => [];
}

final class RecommendedMoviesStateLoading extends RecommendedMoviesState {
  @override
  List<Object?> get props => [];
}

final class RecommendedMoviesStateError extends RecommendedMoviesState {
  final String message;

  const RecommendedMoviesStateError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class RecommendedMoviesStateSuccess extends RecommendedMoviesState {
  final List<Movie> data;

  const RecommendedMoviesStateSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}
