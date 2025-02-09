mixin ShowTable {
  abstract final int id;
  abstract final String? title;
  abstract final String? posterPath;
  abstract final String? overview;
  abstract final String? showType;

  Map<String, dynamic> toJson();
}
