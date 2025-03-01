import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv_series/tv_series_recommended/tv_series_recommended_cubit.dart';
import 'package:equatable/equatable.dart';

part 'recommended_movies_state.dart';

class RecommendedMoviesCubit extends Cubit<RecommendedMoviesState> {
  final GetMovieRecommendations getMovieRecommendations;

  RecommendedMoviesCubit(this.getMovieRecommendations)
      : super(RecommendedMoviesInitial());

  Future<void> fetchMoviesRecommendation(int id) async {
    emit(RecommendedMoviesStateLoading());

    await getMovieRecommendations.execute(id).then((res) {
      res.fold((failure) {
        emit(RecommendedMoviesStateError(message: failure.message));
      }, (data) {
        emit(RecommendedMoviesStateSuccess(data: data));
      });
    });
  }
}
