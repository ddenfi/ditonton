import 'package:ditonton/domain/entities/tv_series/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable {
  TvSeriesResponse({
    this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  TvSeriesResponse.fromJson(dynamic json) {
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(TvSeriesModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  int? page;
  List<TvSeriesModel> results = [];
  int? totalPages;
  int? totalResults;

  TvSeriesResponse copyWith({
    int? page,
    List<TvSeriesModel>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      TvSeriesResponse(
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['results'] = results.map((v) => v.toJson()).toList();
    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    return map;
  }

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];
}

class TvSeriesModel extends Equatable {
  TvSeriesModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    required this.id,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.firstAirDate,
    this.name,
    this.voteAverage,
    this.voteCount,
  });

  factory TvSeriesModel.fromJson(dynamic json) {
    return TvSeriesModel(
        adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds:
            json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [],
        id: json['id'],
        originCountry: json['origin_country'] != null
            ? json['origin_country'].cast<String>()
            : [],
        originalLanguage: json['original_language'],
        originalName: json['original_name'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        firstAirDate: json['first_air_date'],
        name: json['name'],
        voteAverage: (json['vote_average'] as num).toDouble(),
        voteCount: json['vote_count']);
  }

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int id;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  String? name;
  double? voteAverage;
  int? voteCount;

  TvSeriesModel copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    List<String>? originCountry,
    String? originalLanguage,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    String? firstAirDate,
    String? name,
    double? voteAverage,
    int? voteCount,
  }) =>
      TvSeriesModel(
        adult: adult ?? this.adult,
        backdropPath: backdropPath ?? this.backdropPath,
        genreIds: genreIds ?? this.genreIds,
        id: id ?? this.id,
        originCountry: originCountry ?? this.originCountry,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalName: originalName ?? this.originalName,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        posterPath: posterPath ?? this.posterPath,
        firstAirDate: firstAirDate ?? this.firstAirDate,
        name: name ?? this.name,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['backdrop_path'] = backdropPath;
    map['genre_ids'] = genreIds;
    map['id'] = id;
    map['origin_country'] = originCountry;
    map['original_language'] = originalLanguage;
    map['original_name'] = originalName;
    map['overview'] = overview;
    map['popularity'] = popularity;
    map['poster_path'] = posterPath;
    map['first_air_date'] = firstAirDate;
    map['name'] = name;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }

  TvSeries toEntity() {
    return TvSeries(
        adult: adult,
        backdropPath: backdropPath,
        firstAirDate: firstAirDate,
        genreIds: genreIds,
        id: id,
        name: name,
        originalLanguage: originalLanguage,
        originalName: originalName,
        originCountry: originCountry,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        voteAverage: voteAverage,
        voteCount: voteCount);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalLanguage,
        originCountry,
        originalName,
        overview,
        popularity,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount
      ];
}
