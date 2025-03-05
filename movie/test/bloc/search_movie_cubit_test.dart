import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/search_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie/blocs/search_movies/search_movies_cubit.dart';
import 'package:dartz/dartz.dart';
import 'search_movie_cubit_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMoviesCubit searchMoviesCubit;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMoviesCubit = SearchMoviesCubit(mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(searchMoviesCubit.state, SearchMoviesInitial());
  });

  const tId = 1;
  const query = "Spider-Man";

  blocTest<SearchMoviesCubit, SearchMoviesState>(
    'Should emit [Loading, Success] when data of movie recommendation is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(query))
          .thenAnswer((_) async => Right(testMovieList));
      return searchMoviesCubit;
    },
    act: (cubit) => cubit.fetchMovieSearch(query),
    expect: () =>
        [SearchMoviesLoading(), SearchMoviesSuccess(data: testMovieList)],
    verify: (cubit) {
      verify(mockSearchMovies.execute(query));
    },
  );

  blocTest<SearchMoviesCubit, SearchMoviesState>(
    'Should emit [Loading, Error] when get get movie detail is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(query))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchMoviesCubit;
    },
    act: (cubit) => cubit.fetchMovieSearch(query),
    expect: () => [
      SearchMoviesLoading(),
      SearchMoviesError(message: 'Server Failure'),
    ],
    verify: (cubit) {
      verify(mockSearchMovies.execute(query));
    },
  );
}
