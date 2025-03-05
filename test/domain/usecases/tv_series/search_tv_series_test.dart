import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:core/domain/usecases/tv_series/search_tv_series.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries useCase;
  late MockTvSeriesRepositories mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepositories();
    useCase = SearchTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];
  final tQuery = 'Spiderman';

  test('should get list of TvSeries from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.searchShow(tQuery))
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await useCase.execute(tQuery);
    // assert
    expect(result, Right(tTvSeries));
  });
}
