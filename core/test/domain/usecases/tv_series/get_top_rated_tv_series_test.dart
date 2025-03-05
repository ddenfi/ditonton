import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:core/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvSeries useCase;
  late MockTvSeriesRepositories mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTvSeriesRepositories();
    useCase = GetTopRatedTvSeries(mockMovieRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('should get list of TvSeries from repository', () async {
    // arrange
    when(mockMovieRepository.getTopRatedShow())
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(tTvSeries));
  });
}
