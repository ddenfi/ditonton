import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_state.dart';

class TvSeriesDetailCubit extends Cubit<TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;

  TvSeriesDetailCubit(this.getTvSeriesDetail) : super(TvSeriesDetailInitial());

  Future<void> fetchTvSeriesDetail(int id) async {
    emit(TvSeriesDetailStateLoading());

    await getTvSeriesDetail.execute(id).then((res) {
      res.fold((failure) {
        emit(TvSeriesDetailStateError(message: failure.message));
      }, (data) {
        emit(TvSeriesDetailStateSuccess(data: data));
      });
    });
  }
}
