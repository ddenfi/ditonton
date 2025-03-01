import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_now_playing_state.dart';

class TvSeriesNowPlayingCubit extends Cubit<TvSeriesNowPlayingState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  TvSeriesNowPlayingCubit(this.getNowPlayingTvSeries)
      : super(TvSeriesNowPlayingInitial());

  Future<void> fetchNowPlayingTvSeries() async {
    emit(TvSeriesNowPlayingStateLoading());

    await getNowPlayingTvSeries.execute().then((res) {
      res.fold((failure) {
        emit(TvSeriesNowPlayingStateError(message: failure.message));
      }, (data) {
        emit(TvSeriesNowPlayingStateSuccess(data: data));
      });
    });
  }
}
