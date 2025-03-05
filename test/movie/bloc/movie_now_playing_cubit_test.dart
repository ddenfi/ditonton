import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/blocs/now_playing_movies/now_playing_movies_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_now_playing_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesCubit nowPlayingMovieCubit;
  late MockGetNowPlayingMovies mockNowPlayingMovies;

  setUp(() {
    mockNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieCubit = NowPlayingMoviesCubit(mockNowPlayingMovies);
  });

  test('initial state should be empty', () {
    expect(nowPlayingMovieCubit.state, NowPlayingMoviesInitial());
  });

  const tId = 1;

  blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
    'Should emit [Loading, Success] when data of now playing movie is gotten successfully',
    build: () {
      when(mockNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return nowPlayingMovieCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingMovies(),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesSuccess(data: testMovieList)
    ],
    verify: (cubit) {
      verify(mockNowPlayingMovies.execute());
    },
  );

  blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
    'Should emit [Loading, Error] when get now playing movie is unsuccessful',
    build: () {
      when(mockNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingMovieCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingMovies(),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesError(message: 'Server Failure'),
    ],
    verify: (cubit) {
      verify(mockNowPlayingMovies.execute());
    },
  );
}
