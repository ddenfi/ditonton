

import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

import 'show_table.dart';

class MovieTable extends Equatable with ShowTable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? showType;

  MovieTable({
    this.showType = 'movie',
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      overview: movie.overview,
      showType: 'movie');

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
      id: map['id'],
      title: map['title'],
      posterPath: map['posterPath'],
      overview: map['overview'],
      showType: map['showType']);

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'showType': showType
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview, showType];
}
