import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries useCase;
  late MockTvSeriesRepositories mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepositories();
    useCase = GetPopularTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  group('GetPopularTvSeries Tests', () {
    group('execute', () {
      test(
          'should get list of TvSeries from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvSeriesRepository.getPopularShow())
            .thenAnswer((_) async => Right(tTvSeries));
        // act
        final result = await useCase.execute();
        // assert
        expect(result, Right(tTvSeries));
      });
    });
  });
}
