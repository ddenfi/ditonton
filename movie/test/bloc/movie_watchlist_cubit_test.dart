import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie/blocs/movie_watchlist/movie_watchlist_cubit.dart';
import 'package:dartz/dartz.dart';
import 'movie_watchlist_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MovieWatchlistCubit watchlistMoviesCubit;
  late MockGetWatchlistMovies mockWatchlistMovies;

  setUp(() {
    mockWatchlistMovies = MockGetWatchlistMovies();
    watchlistMoviesCubit =
        MovieWatchlistCubit(getWatchlistMovies: mockWatchlistMovies);
  });

  test('initial state should be empty', () {
    expect(watchlistMoviesCubit.state, MovieWatchlistInitial());
  });

  blocTest<MovieWatchlistCubit, MovieWatchlistState>(
    'Should emit [Loading, Success] when data of watchlist movie is gotten successfully',
    build: () {
      when(mockWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return watchlistMoviesCubit;
    },
    act: (cubit) => cubit.fetchWatchlistMovie(),
    expect: () =>
        [MovieWatchlistLoading(), MovieWatchlistSuccess(movies: testMovieList)],
    verify: (cubit) {
      verify(mockWatchlistMovies.execute());
    },
  );

  blocTest<MovieWatchlistCubit, MovieWatchlistState>(
    'Should emit [Loading, Error] when get watchlist movie is unsuccessful',
    build: () {
      when(mockWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistMoviesCubit;
    },
    act: (cubit) => cubit.fetchWatchlistMovie(),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistError(message: 'Server Failure'),
    ],
    verify: (cubit) {
      verify(mockWatchlistMovies.execute());
    },
  );
}
