import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:core/domain/usecases/tv_series/search_tv_series.dart';
import 'package:flutter/cupertino.dart';

part 'tv_series_search_state.dart';

class TvSeriesSearchCubit extends Cubit<TvSeriesSearchState> {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchCubit(this.searchTvSeries) : super(TvSeriesSearchInitial());

  Future<void> fetchSearchTvSeries(String query) async {
    emit(TvSeriesSearchStateLoading());

    await searchTvSeries.execute(query).then((res) {
      res.fold((failure) {
        emit(TvSeriesSearchStateError(message: failure.message));
      }, (data) {
        emit(TvSeriesSearchStateSuccess(data: data));
      });
    });
  }
}
