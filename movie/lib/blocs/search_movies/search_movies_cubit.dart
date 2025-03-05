import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/search_movies.dart';

part 'search_movies_state.dart';

class SearchMoviesCubit extends Cubit<SearchMoviesState> {
  final SearchMovies searchMovies;

  SearchMoviesCubit(this.searchMovies) : super(SearchMoviesInitial());

  Future<void> fetchMovieSearch(String query) async {
    emit(SearchMoviesLoading());

    await searchMovies.execute(query).then((res) {
      res.fold((failure) {
        emit(SearchMoviesError(message: failure.message));
      }, (data) {
        emit(SearchMoviesSuccess(data: data));
      });
    });
  }
}
