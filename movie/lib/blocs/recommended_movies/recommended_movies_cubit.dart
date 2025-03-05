

import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';

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
