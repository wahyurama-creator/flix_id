class Movie {
  final int id;
  final String title;
  final String? posterPath;

  const Movie({
    required this.id,
    required this.title,
    this.posterPath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Movie &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          posterPath == other.posterPath);

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ posterPath.hashCode;

  @override
  String toString() {
    return 'Movie{ id: $id, title: $title, posterPath: $posterPath,}';
  }

  Movie copyWith({
    int? id,
    String? title,
    String? posterPath,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      posterPath: posterPath ?? this.posterPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      title: map['title'] as String,
      posterPath: map['poster_path'] as String,
    );
  }

}
