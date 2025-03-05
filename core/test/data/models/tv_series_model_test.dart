import 'package:core/data/models/tv_series/tv_series_response.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    name: "Breaking Bad",
    firstAirDate: "11-11-2020",
    originalLanguage: "en",
    originalName: "Breaking Bad",
    originCountry: ["US"],
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeries = TvSeries(
    originCountry: ["US"],
    originalName: "Breaking Bad",
    originalLanguage: "en",
    firstAirDate: "11-11-2020",
    name: "Breaking Bad",
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  test('should be a subclass of TvSeries entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
