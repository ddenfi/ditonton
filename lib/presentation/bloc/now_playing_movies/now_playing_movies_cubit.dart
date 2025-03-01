import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesCubit(this.getNowPlayingMovies)
      : super(NowPlayingMoviesInitial());

  Future<void> fetchNowPlayingMovies() async {
    emit(NowPlayingMoviesLoading());

    await getNowPlayingMovies.execute().then((res) {
      res.fold((failure) {
        emit(NowPlayingMoviesError(message: failure.message));
      }, (data) {
        emit(NowPlayingMoviesSuccess(data: data));
      });
    });
  }
}
