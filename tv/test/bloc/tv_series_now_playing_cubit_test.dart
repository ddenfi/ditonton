import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tv_series/get_now_playing_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/blocs/tv_series_now_playing/tv_series_now_playing_cubit.dart';

import 'tv_series_now_playing_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late TvSeriesNowPlayingCubit nowPlayingTvSeriesCubit;
  late MockGetNowPlayingTvSeries mockNowPlayingTvSeries;

  setUp(() {
    mockNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    nowPlayingTvSeriesCubit = TvSeriesNowPlayingCubit(mockNowPlayingTvSeries);
  });

  test('initial state should be empty', () {
    expect(nowPlayingTvSeriesCubit.state, TvSeriesNowPlayingInitial());
  });

  blocTest<TvSeriesNowPlayingCubit, TvSeriesNowPlayingState>(
    'Should emit [Loading, Success] when data of Now Playing Tv Series  is gotten successfully',
    build: () {
      when(mockNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return nowPlayingTvSeriesCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingTvSeries(),
    expect: () => [
      TvSeriesNowPlayingStateLoading(),
      TvSeriesNowPlayingStateSuccess(data: testTvSeriesList)
    ],
    verify: (cubit) {
      verify(mockNowPlayingTvSeries.execute());
    },
  );

  blocTest<TvSeriesNowPlayingCubit, TvSeriesNowPlayingState>(
    'Should emit [Loading, Error] when get Now Playing Tv Series is unsuccessful',
    build: () {
      when(mockNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingTvSeriesCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingTvSeries(),
    expect: () => [
      TvSeriesNowPlayingStateLoading(),
      TvSeriesNowPlayingStateError(message: 'Server Failure'),
    ],
    verify: (cubit) {
      verify(mockNowPlayingTvSeries.execute());
    },
  );
}
