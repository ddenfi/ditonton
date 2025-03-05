import 'package:equatable/equatable.dart';

class TvSeries extends Equatable {
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
  num? voteAverage;
  int? voteCount;

//<editor-fold desc="Data Methods">
  TvSeries({
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

  @override
  String toString() {
    return 'TvSeries{' +
        ' adult: $adult,' +
        ' backdropPath: $backdropPath,' +
        ' genreIds: $genreIds,' +
        ' id: $id,' +
        ' originCountry: $originCountry,' +
        ' originalLanguage: $originalLanguage,' +
        ' originalName: $originalName,' +
        ' overview: $overview,' +
        ' popularity: $popularity,' +
        ' posterPath: $posterPath,' +
        ' firstAirDate: $firstAirDate,' +
        ' name: $name,' +
        ' voteAverage: $voteAverage,' +
        ' voteCount: $voteCount,' +
        '}';
  }

  TvSeries copyWith({
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
  }) {
    return TvSeries(
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
  }

  TvSeries.watchList({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
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
//</editor-fold>
}
