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
  double? voteAverage;
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TvSeries &&
          runtimeType == other.runtimeType &&
          adult == other.adult &&
          backdropPath == other.backdropPath &&
          genreIds == other.genreIds &&
          id == other.id &&
          originCountry == other.originCountry &&
          originalLanguage == other.originalLanguage &&
          originalName == other.originalName &&
          overview == other.overview &&
          popularity == other.popularity &&
          posterPath == other.posterPath &&
          firstAirDate == other.firstAirDate &&
          name == other.name &&
          voteAverage == other.voteAverage &&
          voteCount == other.voteCount);

  @override
  int get hashCode =>
      adult.hashCode ^
      backdropPath.hashCode ^
      genreIds.hashCode ^
      id.hashCode ^
      originCountry.hashCode ^
      originalLanguage.hashCode ^
      originalName.hashCode ^
      overview.hashCode ^
      popularity.hashCode ^
      posterPath.hashCode ^
      firstAirDate.hashCode ^
      name.hashCode ^
      voteAverage.hashCode ^
      voteCount.hashCode;

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

  Map<String, dynamic> toJson() {
    return {
      'adult': this.adult,
      'backdropPath': this.backdropPath,
      'genreIds': this.genreIds,
      'id': this.id,
      'originCountry': this.originCountry,
      'originalLanguage': this.originalLanguage,
      'originalName': this.originalName,
      'overview': this.overview,
      'popularity': this.popularity,
      'posterPath': this.posterPath,
      'firstAirDate': this.firstAirDate,
      'name': this.name,
      'voteAverage': this.voteAverage,
      'voteCount': this.voteCount,
    };
  }

  factory TvSeries.fromJson(Map<String, dynamic> map) {
    return TvSeries(
      adult: map['adult'] as bool,
      backdropPath: map['backdropPath'] as String,
      genreIds: map['genreIds'] as List<int>,
      id: map['id'] as int,
      originCountry: map['originCountry'] as List<String>,
      originalLanguage: map['originalLanguage'] as String,
      originalName: map['originalName'] as String,
      overview: map['overview'] as String,
      popularity: map['popularity'] as double,
      posterPath: map['posterPath'] as String,
      firstAirDate: map['firstAirDate'] as String,
      name: map['name'] as String,
      voteAverage: map['voteAverage'] as double,
      voteCount: map['voteCount'] as int,
    );
  }


  TvSeries.watchList({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

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
//</editor-fold>
}
