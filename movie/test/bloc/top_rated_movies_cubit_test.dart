import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/blocs/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:dartz/dartz.dart';
import 'top_rated_movies_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesCubit topRatedMoviesCubit;
  late MockGetTopRatedMovies mockTopRatedMovies;

  setUp(() {
    mockTopRatedMovies = MockGetTopRatedMovies();
    topRatedMoviesCubit = TopRatedMoviesCubit(mockTopRatedMovies);
  });

  test('initial state should be empty', () {
    expect(topRatedMoviesCubit.state, TopRatedMoviesInitial());
  });

  const tId = 1;

  blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
    'Should emit [Loading, Success] when data of movie recommendation is gotten successfully',
    build: () {
      when(mockTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return topRatedMoviesCubit;
    },
    act: (cubit) => cubit.fetchTopRatedMovies(),
    expect: () =>
        [TopRatedMoviesLoading(), TopRatedMoviesSuccess(data: testMovieList)],
    verify: (cubit) {
      verify(mockTopRatedMovies.execute());
    },
  );

  blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
    'Should emit [Loading, Error] when get get movie detail is unsuccessful',
    build: () {
      when(mockTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedMoviesCubit;
    },
    act: (cubit) => cubit.fetchTopRatedMovies(),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesError(message: 'Server Failure'),
    ],
    verify: (cubit) {
      verify(mockTopRatedMovies.execute());
    },
  );
}
