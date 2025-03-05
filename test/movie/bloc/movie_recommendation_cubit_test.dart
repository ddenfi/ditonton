import 'package:core/common/failure.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie/blocs/recommended_movies/recommended_movies_cubit.dart';
import 'package:dartz/dartz.dart';
import '../../dummy_data/dummy_objects.dart';
import 'movie_recommendation_cubit_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendedMoviesCubit recommendedMovieCubit;
  late MockGetMovieRecommendations mockRecommendedMovie;

  setUp(() {
    mockRecommendedMovie = MockGetMovieRecommendations();
    recommendedMovieCubit = RecommendedMoviesCubit(mockRecommendedMovie);
  });

  test('initial state should be empty', () {
    expect(recommendedMovieCubit.state, RecommendedMoviesInitial());
  });

  const tId = 1;

  blocTest<RecommendedMoviesCubit, RecommendedMoviesState>(
    'Should emit [Loading, Success] when data of movie recommendation is gotten successfully',
    build: () {
      when(mockRecommendedMovie.execute(tId))
          .thenAnswer((_) async => Right(testMovieList));
      return recommendedMovieCubit;
    },
    act: (cubit) => cubit.fetchMoviesRecommendation(tId),
    expect: () => [
      RecommendedMoviesStateLoading(),
      RecommendedMoviesStateSuccess(data: testMovieList)
    ],
    verify: (cubit) {
      verify(mockRecommendedMovie.execute(tId));
    },
  );

  blocTest<RecommendedMoviesCubit, RecommendedMoviesState>(
    'Should emit [Loading, Error] when get movie recommendation is unsuccessful',
    build: () {
      when(mockRecommendedMovie.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return recommendedMovieCubit;
    },
    act: (cubit) => cubit.fetchMoviesRecommendation(tId),
    expect: () => [
      RecommendedMoviesStateLoading(),
      RecommendedMoviesStateError(message: 'Server Failure'),
    ],
    verify: (cubit) {
      verify(mockRecommendedMovie.execute(tId));
    },
  );
}
