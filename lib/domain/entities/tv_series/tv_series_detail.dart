import 'package:ditonton/data/models/tv_series/tv_series_detail_response.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  TvSeriesDetail({
    this.adult,
    this.backdropPath,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    required this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.name,
    this.nextEpisodeToAir,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  bool? adult;
  String? backdropPath;
  List<int>? episodeRunTime;
  String? firstAirDate;
  List<Genre>? genres;
  String? homepage;
  int id;
  bool? inProduction;
  List<String>? languages;
  String? lastAirDate;
  String? name;
  dynamic nextEpisodeToAir;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;

  TvSeriesDetail copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? episodeRunTime,
    String? firstAirDate,
    List<Genre>? genres,
    String? homepage,
    int? id,
    bool? inProduction,
    List<String>? languages,
    String? lastAirDate,
    String? name,
    dynamic nextEpisodeToAir,
    int? numberOfEpisodes,
    int? numberOfSeasons,
    List<String>? originCountry,
    String? originalLanguage,
    String? originalName,
    String? overview,
    double? popularity,
    String? posterPath,
    String? status,
    String? tagline,
    String? type,
    double? voteAverage,
    int? voteCount,
  }) =>
      TvSeriesDetail(
        adult: adult ?? this.adult,
        backdropPath: backdropPath ?? this.backdropPath,
        episodeRunTime: episodeRunTime ?? this.episodeRunTime,
        firstAirDate: firstAirDate ?? this.firstAirDate,
        genres: genres ?? this.genres,
        homepage: homepage ?? this.homepage,
        id: id ?? this.id,
        inProduction: inProduction ?? this.inProduction,
        languages: languages ?? this.languages,
        lastAirDate: lastAirDate ?? this.lastAirDate,
        name: name ?? this.name,
        nextEpisodeToAir: nextEpisodeToAir ?? this.nextEpisodeToAir,
        numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
        numberOfSeasons: numberOfSeasons ?? this.numberOfSeasons,
        originCountry: originCountry ?? this.originCountry,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalName: originalName ?? this.originalName,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        posterPath: posterPath ?? this.posterPath,
        status: status ?? this.status,
        tagline: tagline ?? this.tagline,
        type: type ?? this.type,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['backdrop_path'] = backdropPath;
    map['episode_run_time'] = episodeRunTime;
    map['first_air_date'] = firstAirDate;
    if (genres != null) {
      map['genres'] = genres?.map((v) => v.toMap()).toList();
    }
    map['homepage'] = homepage;
    map['id'] = id;
    map['in_production'] = inProduction;
    map['languages'] = languages;
    map['last_air_date'] = lastAirDate;
    map['name'] = name;
    map['next_episode_to_air'] = nextEpisodeToAir;
    map['number_of_episodes'] = numberOfEpisodes;
    map['number_of_seasons'] = numberOfSeasons;
    map['origin_country'] = originCountry;
    map['original_language'] = originalLanguage;
    map['original_name'] = originalName;
    map['overview'] = overview;
    map['popularity'] = popularity;
    map['poster_path'] = posterPath;
    map['status'] = status;
    map['tagline'] = tagline;
    map['type'] = type;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        name,
        nextEpisodeToAir,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
