import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
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

import 'tv_series_recommendation_cubit_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late TvSeriesRecommendedCubit recommendedTvSeriesCubit;
  late MockGetTvSeriesRecommendations mockRecommendedTvSeries;

  setUp(() {
    mockRecommendedTvSeries = MockGetTvSeriesRecommendations();
    recommendedTvSeriesCubit = TvSeriesRecommendedCubit(mockRecommendedTvSeries);
  });

  test('initial state should be empty', () {
    expect(recommendedTvSeriesCubit.state, TvSeriesRecommendedInitial());
  });

  const tId = 1;

  blocTest<TvSeriesRecommendedCubit, TvSeriesRecommendedState>(
    'Should emit [Loading, Success] when data of Tv Series recommendation is gotten successfully',
    build: () {
      when(mockRecommendedTvSeries.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesList));
      return recommendedTvSeriesCubit;
    },
    act: (cubit) => cubit.fetchRecommendedTvSeries(tId),
    expect: () =>
    [
      TvSeriesRecommendedStateLoading(),
    TvSeriesRecommendedStateSuccess(data: testTvSeriesList)],
    verify: (cubit) {
      verify(mockRecommendedTvSeries.execute(tId));
    },
  );

  blocTest<TvSeriesRecommendedCubit, TvSeriesRecommendedState>(
    'Should emit [Loading, Error] when get Tv Series recommendation is unsuccessful',
    build: () {
      when(mockRecommendedTvSeries.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendedTvSeriesCubit;
    },
    act: (cubit) => cubit.fetchRecommendedTvSeries(tId),
    expect: () =>
    [
      TvSeriesRecommendedStateLoading(),
       TvSeriesRecommendedStateError(message: 'Server Failure'),
    ],
    verify: (cubit) {
      verify(mockRecommendedTvSeries.execute(tId));
    },
  );
}