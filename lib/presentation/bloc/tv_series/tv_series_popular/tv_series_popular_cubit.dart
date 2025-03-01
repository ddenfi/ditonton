import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_popular_state.dart';

class TvSeriesPopularCubit extends Cubit<TvSeriesPopularState> {
  final GetPopularTvSeries getPopularTvSeries;

  TvSeriesPopularCubit(this.getPopularTvSeries)
      : super(TvSeriesPopularInitial());

  Future<void> fetchPopularTvSeries() async {
    emit(TvSeriesPopularStateLoading());

    await getPopularTvSeries.execute().then((res) {
      res.fold((failure) {
        emit(TvSeriesPopularStateError(message: failure.message));
      }, (data) {
        emit(TvSeriesPopularStateSuccess(data: data));
      });
    });
  }
}
