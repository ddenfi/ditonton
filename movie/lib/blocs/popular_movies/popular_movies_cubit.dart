
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesCubit(this.getPopularMovies) : super(PopularMoviesInitial());

  Future<void> fetchPopularMovies() async {
    emit(PopularMoviesLoading());
    final result = await getPopularMovies.execute();
    result.fold((failure) {
      emit(PopularMoviesError(message: failure.message));
    }, (data) {
      emit(PopularMoviesSuccess(data: data));
    });
  }
}
