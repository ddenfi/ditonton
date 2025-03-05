import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/blocs/tv_series_popular/tv_series_popular_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_popular_cubit_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late TvSeriesPopularCubit popularTvSeriesCubit;
  late MockGetPopularTvSeries mockPopularTvSeries;

  setUp(() {
    mockPopularTvSeries = MockGetPopularTvSeries();
    popularTvSeriesCubit = TvSeriesPopularCubit(mockPopularTvSeries);
  });

  test('initial state should be empty', () {
    expect(popularTvSeriesCubit.state, TvSeriesPopularInitial());
  });

  const tId = 1;

  blocTest<TvSeriesPopularCubit, TvSeriesPopularState>(
    'Should emit [Loading, Success] when data of Popular Tv Series is gotten successfully',
    build: () {
      when(mockPopularTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return popularTvSeriesCubit;
    },
    act: (cubit) => cubit.fetchPopularTvSeries(),
    expect: () => [
      TvSeriesPopularStateLoading(),
      TvSeriesPopularStateSuccess(data: testTvSeriesList)
    ],
    verify: (cubit) {
      verify(mockPopularTvSeries.execute());
    },
  );

  blocTest<TvSeriesPopularCubit, TvSeriesPopularState>(
    'Should emit [Loading, Error] when get Popular Tv Series is unsuccessful',
    build: () {
      when(mockPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvSeriesCubit;
    },
    act: (cubit) => cubit.fetchPopularTvSeries(),
    expect: () => [
      TvSeriesPopularStateLoading(),
      TvSeriesPopularStateError(message: 'Server Failure'),
    ],
    verify: (cubit) {
      verify(mockPopularTvSeries.execute());
    },
  );
}
