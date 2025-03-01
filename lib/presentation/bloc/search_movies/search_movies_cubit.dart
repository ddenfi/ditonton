import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

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
