import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';

part 'tv_series_top_rated_state.dart';

class TvSeriesTopRatedCubit extends Cubit<TvSeriesTopRatedState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvSeriesTopRatedCubit(this.getTopRatedTvSeries)
      : super(TvSeriesTopRatedInitial());

  Future<void> fetchTopRatedTvSeries() async {
    emit(TvSeriesTopRatedStateLoading());
    await getTopRatedTvSeries.execute().then((res) {
      res.fold((failure) {
        emit(TvSeriesTopRatedStateError(message: failure.message));
      }, (data) {
        emit(TvSeriesTopRatedStateSuccess(data: data));
      });
    });
  }
}
