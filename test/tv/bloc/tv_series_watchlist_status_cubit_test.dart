import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/tv_series/get_watchlist_tv_series_status.dart';
import 'package:core/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:core/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/blocs/tv_series_watchlist_status/tv_series_watchlist_status_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_status_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvSeriesStatus,
  RemoveWatchlistTvSeries,
  SaveWatchlistTvSeries
])
void main() {
  late TvSeriesWatchlistStatusCubit watchlistStatusTvSeriesCubit;
  late MockGetWatchlistTvSeriesStatus mockWatchlistStatusTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  setUp(() {
    mockWatchlistStatusTvSeries = MockGetWatchlistTvSeriesStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    watchlistStatusTvSeriesCubit = TvSeriesWatchlistStatusCubit(
        mockWatchlistStatusTvSeries,
        mockRemoveWatchlistTvSeries,
        mockSaveWatchlistTvSeries);
  });

  const tId = 1;

  blocTest<TvSeriesWatchlistStatusCubit, TvSeriesWatchlistStatusState>(
    'Should get the watchlist status',
    build: () {
      when(mockWatchlistStatusTvSeries.execute(tId))
          .thenAnswer((_) async => true);
      return watchlistStatusTvSeriesCubit;
    },
    act: (cubit) => cubit.loadWatchlistStatus(tId),
    expect: () => [TvSeriesWatchlistStatus(isAddedToWatchlist: true)],
    verify: (cubit) {
      verify(mockWatchlistStatusTvSeries.execute(tId));
    },
  );

  blocTest<TvSeriesWatchlistStatusCubit, TvSeriesWatchlistStatusState>(
    'Should execute save watchlist when function called',
    build: () {
      when(mockWatchlistStatusTvSeries.execute(tId))
          .thenAnswer((_) async => true);
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer(
        (_) async => Right("Added to Watchlist"),
      );
      return watchlistStatusTvSeriesCubit;
    },
    act: (cubit) async => cubit.addWatchlist(testTvSeriesDetail),
    expect: () => [
      TvSeriesWatchlistStatus(isAddedToWatchlist: true),
    ],
    verify: (cubit) {
      verify(mockWatchlistStatusTvSeries.execute(tId));
      expect(cubit.watchlistMessage, "Added to Watchlist");
    },
  );

  blocTest<TvSeriesWatchlistStatusCubit, TvSeriesWatchlistStatusState>(
    'Should execute remove watchlist when function called',
    build: () {
      when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer(
        (_) async => Right("Remove to Watchlist"),
      );
      when(mockWatchlistStatusTvSeries.execute(tId))
          .thenAnswer((_) async => false);

      return watchlistStatusTvSeriesCubit;
    },
    act: (cubit) => cubit.removeFromWatchlist(testTvSeriesDetail),
    expect: () => [
      TvSeriesWatchlistStatus(isAddedToWatchlist: false),
    ],
    verify: (cubit) {
      verify(mockWatchlistStatusTvSeries.execute(tId));
      expect(cubit.watchlistMessage, "Remove to Watchlist");
    },
  );

  blocTest<TvSeriesWatchlistStatusCubit, TvSeriesWatchlistStatusState>(
    'Should should update watchlist status when add watchlist success',
    build: () {
      when(mockWatchlistStatusTvSeries.execute(tId))
          .thenAnswer((_) async => false);
      when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer(
        (_) async => Right("Remove to Watchlist"),
      );
      return watchlistStatusTvSeriesCubit;
    },
    act: (cubit) => cubit.removeFromWatchlist(testTvSeriesDetail),
    expect: () => [
      TvSeriesWatchlistStatus(isAddedToWatchlist: false),
    ],
    verify: (cubit) {
      verify(mockWatchlistStatusTvSeries.execute(tId));
      expect(cubit.state.isAddedToWatchlist, false);
      expect(cubit.watchlistMessage, "Remove to Watchlist");
    },
  );

  blocTest<TvSeriesWatchlistStatusCubit, TvSeriesWatchlistStatusState>(
    'Should update watchlist message when add watchlist failed',
    build: () {
      when(mockWatchlistStatusTvSeries.execute(tId))
          .thenAnswer((_) async => false);
      when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer(
        (_) async => Left(ServerFailure("Failed")),
      );
      return watchlistStatusTvSeriesCubit;
    },
    act: (cubit) => cubit.removeFromWatchlist(testTvSeriesDetail),
    expect: () => [
      TvSeriesWatchlistStatus(isAddedToWatchlist: false),
    ],
    verify: (cubit) {
      verify(mockWatchlistStatusTvSeries.execute(tId));
      expect(cubit.state.isAddedToWatchlist, false);
      expect(cubit.watchlistMessage, "Failed");
    },
  );
}
