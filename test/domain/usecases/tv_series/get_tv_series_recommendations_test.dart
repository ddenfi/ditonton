import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_tv_series_recommendations.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations useCase;
  late MockTvSeriesRepositories mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepositories();
    useCase = GetTvSeriesRecommendations(mockTvSeriesRepository);
  });

  final tId = 1;
  final tTvSeries = <TvSeries>[];

  test('should get list of TvSeries recommendations from the repository',
      () async {
    // arrange
    when(mockTvSeriesRepository.getShowRecommendations(tId))
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await useCase.execute(tId);
    // assert
    expect(result, Right(tTvSeries));
  });
}
