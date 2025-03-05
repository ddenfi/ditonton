part of 'movie_detail_cubit.dart';

@immutable
sealed class MovieDetailState extends Equatable {}

final class MovieDetailInitial extends MovieDetailState {
  @override
  List<Object?> get props => [];
}

final class MovieDetailLoading extends MovieDetailState {
  @override
  List<Object?> get props => [];
}

final class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class MovieDetailSuccess extends MovieDetailState {
  final MovieDetail movieDetail;

  MovieDetailSuccess({required this.movieDetail});

  @override
  List<Object?> get props => [movieDetail];
}
