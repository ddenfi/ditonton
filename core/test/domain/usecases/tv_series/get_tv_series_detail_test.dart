import 'package:core/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:core/test/dummy_objects.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail useCase;
  late MockTvSeriesRepositories mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepositories();
    useCase = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  final tId = 1;

  test('should get TvSeries detail from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getShowDetail(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    // act
    final result = await useCase.execute(tId);
    // assert
    expect(result, Right(testTvSeriesDetail));
  });
}
