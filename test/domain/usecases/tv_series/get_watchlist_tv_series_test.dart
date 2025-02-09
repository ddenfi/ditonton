import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvSeries useCase;
  late MockTvSeriesRepositories mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTvSeriesRepositories();
    useCase = GetWatchlistTvSeries(mockMovieRepository);
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockMovieRepository.getWatchlistShow())
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(testTvSeriesList));
  });
}
