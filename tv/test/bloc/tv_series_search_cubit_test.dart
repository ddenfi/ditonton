import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:core/domain/usecases/tv_series/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:movie/blocs/recommended_movies/recommended_movies_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/blocs/tv_series_recommended/tv_series_recommended_cubit.dart';
import 'package:tv/blocs/tv_series_search/tv_series_search_cubit.dart';
import 'package:tv/blocs/tv_series_top_rated/tv_series_top_rated_cubit.dart';

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
