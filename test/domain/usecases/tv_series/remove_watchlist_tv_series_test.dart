import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTvSeries useCase;
  late MockTvSeriesRepositories mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepositories();
    useCase = RemoveWatchlistTvSeries(mockTvSeriesRepository);
  });

  test('should remove watchlist TvSeries from repository', () async {
    // arrange
    when(mockTvSeriesRepository.removeWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await useCase.execute(testTvSeriesDetail);
    // assert
    verify(mockTvSeriesRepository.removeWatchlist(testTvSeriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
