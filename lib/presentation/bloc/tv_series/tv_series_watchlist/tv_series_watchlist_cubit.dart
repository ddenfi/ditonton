import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_watchlist_state.dart';

class TvSeriesWatchlistCubit extends Cubit<TvSeriesWatchlistState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  TvSeriesWatchlistCubit(this.getWatchlistTvSeries)
      : super(TvSeriesWatchlistInitial());

  Future<void> fetchWatchlistTvSeries() async {
    emit(TvSeriesWatchlistLoading());
    await getWatchlistTvSeries.execute().then((res) {
      res.fold((failure) {
        emit(TvSeriesWatchlistError(message: failure.message));
      }, (data) {
        emit(TvSeriesWatchlistSuccess(tvSeries: data));
      });
    });
  }
}
