import 'package:core/data/models/show_table.dart';
import 'package:core/domain/entities/tv_series/tv_series.dart';
import 'package:core/domain/entities/tv_series/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesTable extends Equatable with ShowTable {
  @override
  final int id;
  @override
  final String? title;
  @override
  final String? posterPath;
  @override
  final String? overview;
  @override
  final String? showType;

  TvSeriesTable({
    this.showType,
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory TvSeriesTable.fromEntity(TvSeriesDetail show) => TvSeriesTable(
      id: show.id,
      title: show.name,
      posterPath: show.posterPath,
      overview: show.overview,
      showType: "tv-series");

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) => TvSeriesTable(
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

  TvSeries toEntity() => TvSeries.watchList(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: title,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
