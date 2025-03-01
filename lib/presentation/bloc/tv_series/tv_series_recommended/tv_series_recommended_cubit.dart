import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_recommended_state.dart';

class TvSeriesRecommendedCubit extends Cubit<TvSeriesRecommendedState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvSeriesRecommendedCubit(this.getTvSeriesRecommendations)
      : super(TvSeriesRecommendedInitial());

  Future<void> fetchRecommendedTvSeries(int id) async {
    emit(TvSeriesRecommendedStateLoading());

    await getTvSeriesRecommendations.execute(id).then((res) {
      res.fold((failure) {
        emit(TvSeriesRecommendedStateError(message: failure.message));
      }, (data) {
        emit(TvSeriesRecommendedStateSuccess(data: data));
      });
    });
  }
}
