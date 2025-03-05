import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/domain/usecases/search_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:movie/blocs/movie_watchlist/movie_watchlist_cubit.dart';
import 'package:movie/blocs/movie_watchlist_status/movie_watchlist_status_cubit.dart';
import 'package:movie/blocs/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movie/blocs/popular_movies/popular_movies_cubit.dart';
import 'package:movie/blocs/recommended_movies/recommended_movies_cubit.dart';
import 'package:movie/blocs/search_movies/search_movies_cubit.dart';

import 'movie_watchlist_cubit_test.mocks.dart';
import 'movie_watchlist_status_cubit_test.mocks.dart';

@GenerateMocks([GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late MovieWatchlistStatusCubit watchlistStatusMoviesCubit;
  late MockGetWatchListStatus mockWatchlistStatusMovies;
  late MockSaveWatchlist mockSaveWatchlistMovies;
  late MockRemoveWatchlist mockRemoveWatchlistMovies;

  setUp(() {
    mockWatchlistStatusMovies = MockGetWatchListStatus();
    mockSaveWatchlistMovies = MockSaveWatchlist();
    mockRemoveWatchlistMovies = MockRemoveWatchlist();
    watchlistStatusMoviesCubit = MovieWatchlistStatusCubit(
        mockWatchlistStatusMovies,
        mockSaveWatchlistMovies,
        mockRemoveWatchlistMovies);
  });

  const tId = 1;

  blocTest<MovieWatchlistStatusCubit, MovieWatchlistStatusState>(
    'Should get the watchlist status',
    build: () {
      when(mockWatchlistStatusMovies.execute(tId))
          .thenAnswer((_) async => true);
      return watchlistStatusMoviesCubit;
    },
    act: (cubit) => cubit.loadWatchlistStatus(tId),
    expect: () => [MovieWatchlistStatus(isAddedToWatchlist: true)],
    verify: (cubit) {
      verify(mockWatchlistStatusMovies.execute(tId));
    },
  );

  blocTest<MovieWatchlistStatusCubit, MovieWatchlistStatusState>(
    'Should execute save watchlist when function called',
    build: () {
      when(mockWatchlistStatusMovies.execute(tId))
          .thenAnswer((_) async => true);
      when(mockSaveWatchlistMovies.execute(testMovieDetail)).thenAnswer(
        (_) async => Right("Added to watchlist"),
      );

      return watchlistStatusMoviesCubit;
    },
    act: (cubit) => cubit.addWatchlist(testMovieDetail),
    expect: () => [
      MovieWatchlistStatus(isAddedToWatchlist: true),
    ],
    verify: (cubit) {
      verify(mockWatchlistStatusMovies.execute(tId));
      expect(cubit.watchlistMessage, "Added to watchlist");
    },
  );

  blocTest<MovieWatchlistStatusCubit, MovieWatchlistStatusState>(
    'Should execute remove watchlist when function called',
    build: () {
      when(mockWatchlistStatusMovies.execute(tId))
          .thenAnswer((_) async => false);
      when(mockSaveWatchlistMovies.execute(testMovieDetail)).thenAnswer(
            (_) async => Right("Remove from watchlist"),
      );
      return watchlistStatusMoviesCubit;
    },
    act: (cubit) => cubit.addWatchlist(testMovieDetail),
    expect: () => [
      MovieWatchlistStatus(isAddedToWatchlist: false),
    ],
    verify: (cubit) {
      verify(mockWatchlistStatusMovies.execute(tId));
      expect(cubit.watchlistMessage, "Remove from watchlist");
    },
  );

  blocTest<MovieWatchlistStatusCubit, MovieWatchlistStatusState>(
    'Should should update watchlist status when add watchlist success',
    build: () {
      when(mockWatchlistStatusMovies.execute(tId))
          .thenAnswer((_) async => true);
      when(mockSaveWatchlistMovies.execute(testMovieDetail)).thenAnswer(
            (_) async => Right("Remove from watchlist"),
      );
      return watchlistStatusMoviesCubit;
    },
    act: (cubit) => cubit.addWatchlist(testMovieDetail),
    expect: () => [
      MovieWatchlistStatus(isAddedToWatchlist: true),
    ],
    verify: (cubit) {
      verify(mockWatchlistStatusMovies.execute(tId));
      expect(cubit.state.isAddedToWatchlist, true);
      expect(cubit.watchlistMessage, 'Remove from watchlist');
    },
  );

  blocTest<MovieWatchlistStatusCubit, MovieWatchlistStatusState>(
    'Should update watchlist message when add watchlist failed',
    build: () {
      when(mockWatchlistStatusMovies.execute(tId))
          .thenAnswer((_) async => false);
      when(mockSaveWatchlistMovies.execute(testMovieDetail)).thenAnswer(
            (_) async => Right("Failed"),
      );
      return watchlistStatusMoviesCubit;
    },
    act: (cubit) => cubit.addWatchlist(testMovieDetail),
    expect: () => [
      MovieWatchlistStatus(isAddedToWatchlist: false),
    ],
    verify: (cubit) {
      verify(mockWatchlistStatusMovies.execute(tId));
      expect(cubit.state.isAddedToWatchlist, false);
      expect(cubit.watchlistMessage, 'Failed');
    },
  );
}
