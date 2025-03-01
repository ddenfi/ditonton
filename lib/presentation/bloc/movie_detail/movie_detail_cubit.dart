import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailCubit({required this.getMovieDetail})
      : super(MovieDetailInitial());

  Future<void> fetchMovieDetail(int id) async {
    emit(MovieDetailLoading());

    final result = await getMovieDetail.execute(id);

    result.fold((failure) {
      emit(MovieDetailError(message: failure.message));
    }, (data) {
      emit(MovieDetailSuccess(movieDetail: data));
    });
  }
}
