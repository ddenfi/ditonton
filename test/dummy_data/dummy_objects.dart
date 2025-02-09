import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_series/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series_detail.dart';

//Movie
final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'showType': 'movie'
};

//TV Series

final testTvSeries = TvSeries(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    voteAverage: 7.2,
    voteCount: 13507,
    name: "Squid Game",
    firstAirDate: "2020-04-17",
    originalLanguage: "en",
    originalName: "Squid Game",
    originCountry: ["US"]);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: 'backdropPath',
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    originCountry: ["US"],
    originalLanguage: "",
    firstAirDate: "2020-11-11T00:00:00.000Z",
    name: "Squid Game",
    type: "",
    tagline: "",
    status: "Ended",
    numberOfSeasons: 2,
    numberOfEpisodes: 3,
    lastAirDate: "2020-11-11T00:00:00.000Z",
    languages: ["en"],
    inProduction: true,
    homepage: "",
    genres: [],
    episodeRunTime: [60],
    originalName: "Breaking Bad",
    popularity: 3.0);

final testTvSeriesWatchlist = TvSeries.watchList(
  id: 1,
  name: 'Squid Game',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesTable = TvSeriesTable(
  showType: "tv-series",
  id: 1,
  title: 'Squid Game',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'Squid Game',
  "showType": "tv-series"
};
