import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tv_series/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/blocs/tv_series_search/tv_series_search_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_search_cubit_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvSeriesSearchCubit searchTvSeriesCubit;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searchTvSeriesCubit = TvSeriesSearchCubit(mockSearchTvSeries);
  });

  test('initial state should be empty', () {
    expect(searchTvSeriesCubit.state, TvSeriesSearchInitial());
  });

  const query = "Spider-man";

  blocTest<TvSeriesSearchCubit, TvSeriesSearchState>(
    'Should emit [Loading, Success] when data of Search Tv Series is gotten successfully',
    build: () {
      when(mockSearchTvSeries.execute(query))
          .thenAnswer((_) async => Right(testTvSeriesList));
      return searchTvSeriesCubit;
    },
    act: (cubit) => cubit.fetchSearchTvSeries(query),
    expect: () => [
      TvSeriesSearchStateLoading(),
      TvSeriesSearchStateSuccess(data: testTvSeriesList)
    ],
    verify: (cubit) {
      verify(mockSearchTvSeries.execute(query));
    },
  );

  blocTest<TvSeriesSearchCubit, TvSeriesSearchState>(
    'Should emit [Loading, Error] when get Search Tv Series is unsuccessful',
    build: () {
      when(mockSearchTvSeries.execute(query))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchTvSeriesCubit;
    },
    act: (cubit) => cubit.fetchSearchTvSeries(query),
    expect: () => [
      TvSeriesSearchStateLoading(),
      TvSeriesSearchStateError(message: 'Server Failure'),
    ],
    verify: (cubit) {
      verify(mockSearchTvSeries.execute(query));
    },
  );
}
