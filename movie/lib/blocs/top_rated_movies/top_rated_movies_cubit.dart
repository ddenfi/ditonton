
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesCubit(this.getTopRatedMovies) : super(TopRatedMoviesInitial());

  Future<void> fetchTopRatedMovies() async {
    emit(TopRatedMoviesLoading());

    await getTopRatedMovies.execute().then((res) {
      res.fold((failure) {
        emit(TopRatedMoviesError(message: failure.message));
      }, (data) {
        emit(TopRatedMoviesSuccess(data: data));
      });
    });
  }
}
