class Actor {
  final String name;
  final String? profilePath;

  const Actor({
    required this.name,
    this.profilePath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Actor &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          profilePath == other.profilePath);

  @override
  int get hashCode => name.hashCode ^ profilePath.hashCode;

  @override
  String toString() {
    return 'Actor{ name: $name, profilePath: $profilePath,}';
  }

  Actor copyWith({
    String? name,
    String? profilePath,
  }) {
    return Actor(
      name: name ?? this.name,
      profilePath: profilePath ?? this.profilePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profile_path': profilePath,
    };
  }

  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      name: map['name'] as String,
      profilePath: map['profile_path'],
    );
  }
}
