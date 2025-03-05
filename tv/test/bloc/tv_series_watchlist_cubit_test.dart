import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/search_movies.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/blocs/tv_series_watchlist/tv_series_watchlist_cubit.dart';

import 'tv_series_watchlist_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late TvSeriesWatchlistCubit watchlistTvSeriesCubit;
  late MockGetWatchlistTvSeries mockWatchlistTvSeries;

  setUp(() {
    mockWatchlistTvSeries = MockGetWatchlistTvSeries();
    watchlistTvSeriesCubit = TvSeriesWatchlistCubit(mockWatchlistTvSeries);
  });

  test('initial state should be empty', () {
    expect(watchlistTvSeriesCubit.state, TvSeriesWatchlistInitial());
  });

  blocTest<TvSeriesWatchlistCubit, TvSeriesWatchlistState>(
    'Should emit [Loading, Success] when data of Watchlist Tv Series is gotten successfully',
    build: () {
      when(mockWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return watchlistTvSeriesCubit;
    },
    act: (cubit) => cubit.fetchWatchlistTvSeries(),
    expect: () => [
      TvSeriesWatchlistLoading(),
      TvSeriesWatchlistSuccess(tvSeries: testTvSeriesList)
    ],
    verify: (cubit) {
      verify(mockWatchlistTvSeries.execute());
    },
  );

  blocTest<TvSeriesWatchlistCubit, TvSeriesWatchlistState>(
    'Should emit [Loading, Error] when get Watchlist Tv Series is unsuccessful',
    build: () {
      when(mockWatchlistTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTvSeriesCubit;
    },
    act: (cubit) => cubit.fetchWatchlistTvSeries(),
    expect: () => [
      TvSeriesWatchlistLoading(),
      TvSeriesWatchlistError(message: 'Server Failure'),
    ],
    verify: (cubit) {
      verify(mockWatchlistTvSeries.execute());
    },
  );
}
