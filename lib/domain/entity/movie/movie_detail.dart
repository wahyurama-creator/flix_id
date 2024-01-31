class MovieDetail {
  final int id;
  final String title, overview;
  final String? posterPath, backdropPath;
  final int runtime;
  final double voteAverage;
  final List<String> genres;

  const MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.runtime,
    required this.voteAverage,
    required this.genres,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieDetail &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          overview == other.overview &&
          posterPath == other.posterPath &&
          backdropPath == other.backdropPath &&
          runtime == other.runtime &&
          voteAverage == other.voteAverage &&
          genres == other.genres);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      overview.hashCode ^
      posterPath.hashCode ^
      backdropPath.hashCode ^
      runtime.hashCode ^
      voteAverage.hashCode ^
      genres.hashCode;

  @override
  String toString() {
    return 'MovieDetail{ '
        'id: $id, '
        'title: $title, '
        'overview: $overview, '
        'posterPath: $posterPath, '
        'backdropPath: $backdropPath, '
        'runtime: $runtime, '
        'voteAverage: $voteAverage, '
        'genres: $genres,'
        '}';
  }

  MovieDetail copyWith({
    int? id,
    String? title,
    String? overview,
    String? posterPath,
    String? backdropPath,
    int? runtime,
    double? voteAverage,
    List<String>? genres,
  }) {
    return MovieDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      runtime: runtime ?? this.runtime,
      voteAverage: voteAverage ?? this.voteAverage,
      genres: genres ?? this.genres,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'runtime': runtime,
      'voteAverage': voteAverage,
      'genres': genres,
    };
  }

  factory MovieDetail.fromMap(Map<String, dynamic> map) {
    return MovieDetail(
      id: map['id'] as int,
      title: map['title'] as String,
      overview: map['overview'] as String,
      posterPath: map['poster_path'] as String,
      backdropPath: map['backdrop_path'] as String,
      runtime: map['runtime'] as int,
      voteAverage: map['voteAverage'] as double,
      genres: List<String>.from(
        map['genres'].map((e) => e['name']),
      ),
    );
  }
}
