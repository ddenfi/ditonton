import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:core/data/models/tv_series/tv_series_detail_response.dart';
import 'package:core/data/models/tv_series/tv_series_response.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';


import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

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
    voteAverage: 1.0,
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
  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Now Playing TvSeries', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getAiringShow())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getNowPlayingShow();
      // assert
      verify(mockRemoteDataSource.getAiringShow());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getAiringShow()).thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingShow();
      // assert
      verify(mockRemoteDataSource.getAiringShow());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getAiringShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingShow();
      // assert
      verify(mockRemoteDataSource.getAiringShow());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TvSeries', () {
    test('should return TvSeries list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularShow())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getPopularShow();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularShow()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularShow();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularShow();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TvSeries', () {
    test('should return TvSeries list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedShow())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getTopRatedShow();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedShow()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedShow();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedShow())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedShow();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TvSeries Detail', () {
    final tId = 1;
    final tTvSeriesResponse = TvSeriesDetailResponse(
      adult: false,
      name: "Squid Game", // Change to match the name
      originalName: "Breaking Bad",
      episodeRunTime: [60],
      genres: [],
      inProduction: true,
      numberOfEpisodes: 3, // Change to match the number of episodes
      numberOfSeasons: 2, // Change to match the number of seasons
      seasons: [],
      type: "",
      languages: ["en"],
      lastAirDate:
          DateTime.parse("2020-11-11T00:00:00Z"), // Convert date to ISO 8601
      firstAirDate:
          DateTime.parse("2020-11-11T00:00:00Z"), // Convert date to ISO 8601
      backdropPath: 'backdropPath',
      homepage: "", // Change to match the homepage
      originCountry: ["US"],
      id: 1,
      originalLanguage: "",
      overview: 'overview',
      popularity: 3.0, // Change to match the popularity
      posterPath: 'posterPath',
      status: 'Ended', // Change to match the status
      tagline: "", // Change to match the tagline
      voteAverage: 1.0, // Change to double if needed
      voteCount: 1,
    );

    test(
        'should return TvSeries data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getShowDetail(tId))
          .thenAnswer((_) async => tTvSeriesResponse);
      // act
      final result = await repository.getShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getShowDetail(tId));
      expect(result, equals(Right(testTvSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getShowDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getShowDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getShowDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getShowDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TvSeries Recommendations', () {
    final tTvSeriesList = <TvSeriesModel>[];
    final tId = 1;

    test('should return data (TvSeries list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getShowRecommendations(tId))
          .thenAnswer((_) async => tTvSeriesList);
      // act
      final result = await repository.getShowRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getShowRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getShowRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getShowRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getShowRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getShowRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getShowRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getShowRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach TvSeries', () {
    final tQuery = 'spiderman';

    test('should return TvSeries list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchShow(tQuery))
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.searchShow(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchShow(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchShow(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchShow(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchShow(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getShowById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist TvSeries', () {
    test('should return list of TvSeries', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistShows())
          .thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await repository.getWatchlistShow();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testTvSeriesWatchlist]);
    });
  });
}
