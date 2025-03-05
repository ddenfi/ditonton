import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:movie/blocs/recommended_movies/recommended_movies_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/blocs/tv_series_recommended/tv_series_recommended_cubit.dart';
import 'package:tv/blocs/tv_series_top_rated/tv_series_top_rated_cubit.dart';

import 'tv_series_top_rated_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TvSeriesTopRatedCubit topRatedTvSeriesCubit;
  late MockGetTopRatedTvSeries mockRecommendedTvSeries;

  setUp(() {
    mockRecommendedTvSeries = MockGetTopRatedTvSeries();
    topRatedTvSeriesCubit = TvSeriesTopRatedCubit(mockRecommendedTvSeries);
  });

  test('initial state should be empty', () {
    expect(topRatedTvSeriesCubit.state, TvSeriesTopRatedInitial());
  });

  const tId = 1;

  blocTest<TvSeriesTopRatedCubit, TvSeriesTopRatedState>(
    'Should emit [Loading, Success] when data of Top Rated Tv Series is gotten successfully',
    build: () {
      when(mockRecommendedTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return topRatedTvSeriesCubit;
    },
    act: (cubit) => cubit.fetchTopRatedTvSeries(),
    expect: () => [
      TvSeriesTopRatedStateLoading(),
      TvSeriesTopRatedStateSuccess(data: testTvSeriesList)
    ],
    verify: (cubit) {
      verify(mockRecommendedTvSeries.execute());
    },
  );

  blocTest<TvSeriesTopRatedCubit, TvSeriesTopRatedState>(
    'Should emit [Loading, Error] when get Top Rated Tv Series is unsuccessful',
    build: () {
      when(mockRecommendedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvSeriesCubit;
    },
    act: (cubit) => cubit.fetchTopRatedTvSeries(),
    expect: () => [
      TvSeriesTopRatedStateLoading(),
      TvSeriesTopRatedStateError(message: 'Server Failure'),
    ],
    verify: (cubit) {
      verify(mockRecommendedTvSeries.execute());
    },
  );
}
