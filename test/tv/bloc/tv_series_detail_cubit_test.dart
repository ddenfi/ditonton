import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/blocs/tv_series_detail/tv_series_detail_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_cubit_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late TvSeriesDetailCubit tvSeriesDetailCubit;
  late MockGetTvSeriesDetail mockMovieDetail;

  setUp(() {
    mockMovieDetail = MockGetTvSeriesDetail();
    tvSeriesDetailCubit = TvSeriesDetailCubit(mockMovieDetail);
  });

  test('initial state should be empty', () {
    expect(tvSeriesDetailCubit.state, TvSeriesDetailInitial());
  });

  const tId = 1;

  blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
    'Should emit [Loading, HasData] when data of Tv Series detail is gotten successfully',
    build: () {
      when(mockMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      return tvSeriesDetailCubit;
    },
    act: (cubit) => cubit.fetchTvSeriesDetail(tId),
    expect: () => [
      TvSeriesDetailStateLoading(),
      TvSeriesDetailStateSuccess(data: testTvSeriesDetail)
    ],
    verify: (cubit) {
      verify(mockMovieDetail.execute(tId));
    },
  );

  blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
    'Should emit [Loading, Error] when get Tv Series detail is unsuccessful',
    build: () {
      when(mockMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesDetailCubit;
    },
    act: (cubit) => cubit.fetchTvSeriesDetail(tId),
    expect: () => [
      TvSeriesDetailStateLoading(),
      TvSeriesDetailStateError(message: 'Server Failure'),
    ],
    verify: (cubit) {
      verify(mockMovieDetail.execute(tId));
    },
  );
}
