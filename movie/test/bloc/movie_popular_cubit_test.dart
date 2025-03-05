import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:movie/blocs/popular_movies/popular_movies_cubit.dart';

import 'movie_popular_cubit_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesCubit popularMoviesCubit;
  late MockGetPopularMovies mockPopularMovies;

  setUp(() {
    mockPopularMovies = MockGetPopularMovies();
    popularMoviesCubit = PopularMoviesCubit(mockPopularMovies);
  });

  test('initial state should be empty', () {
    expect(popularMoviesCubit.state, PopularMoviesInitial());
  });


  blocTest<PopularMoviesCubit, PopularMoviesState>(
    'Should emit [Loading, Success] when data of popular movie  is gotten successfully',
    build: () {
      when(mockPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return popularMoviesCubit;
    },
    act: (cubit) => cubit.fetchPopularMovies(),
    expect: () =>
        [PopularMoviesLoading(), PopularMoviesSuccess(data: testMovieList)],
    verify: (cubit) {
      verify(mockPopularMovies.execute());
    },
  );

  blocTest<PopularMoviesCubit, PopularMoviesState>(
    'Should emit [Loading, Error] when get popular movie is unsuccessful',
    build: () {
      when(mockPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularMoviesCubit;
    },
    act: (cubit) => cubit.fetchPopularMovies(),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesError(message: 'Server Failure'),
    ],
    verify: (cubit) {
      verify(mockPopularMovies.execute());
    },
  );
}
