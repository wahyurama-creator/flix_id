class User {
  final String uid, email, name;
  final String? photoUrl;
  final int balance;

  const User({
    required this.uid,
    required this.email,
    required this.name,
    this.photoUrl,
    this.balance = 0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          email == other.email &&
          name == other.name &&
          photoUrl == other.photoUrl &&
          balance == other.balance);

  @override
  int get hashCode =>
      uid.hashCode ^
      email.hashCode ^
      name.hashCode ^
      photoUrl.hashCode ^
      balance.hashCode;

  @override
  String toString() {
    return 'User{ '
        'uid: $uid, '
        'email: $email, '
        'name: $name, '
        'photoUrl: $photoUrl, '
        'balance: $balance,'
        '}';
  }

  User copyWith({
    String? uid,
    String? email,
    String? name,
    String? photoUrl,
    int? balance,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'balance': balance,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      photoUrl: map['photoUrl'] as String?,
      balance: map['balance'] as int,
    );
  }
}
