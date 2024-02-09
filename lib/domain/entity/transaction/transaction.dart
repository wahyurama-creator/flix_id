class Transaction {
  final String? id;
  final String uid;
  final int? transactionTime;
  final String? transactionImage;
  final String title;
  final List<String>? seats;
  final String? theaterName;
  final int? watchingTime;
  final int? ticketAmount, ticketPrice;
  final int adminFee, total;

  const Transaction({
    this.id,
    required this.uid,
    this.transactionTime,
    this.transactionImage,
    required this.title,
    this.seats,
    this.theaterName,
    this.watchingTime,
    this.ticketAmount,
    this.ticketPrice,
    required this.adminFee,
    required this.total,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          uid == other.uid &&
          transactionTime == other.transactionTime &&
          transactionImage == other.transactionImage &&
          title == other.title &&
          seats == other.seats &&
          theaterName == other.theaterName &&
          watchingTime == other.watchingTime &&
          ticketAmount == other.ticketAmount &&
          ticketPrice == other.ticketPrice &&
          adminFee == other.adminFee &&
          total == other.total);

  @override
  int get hashCode =>
      id.hashCode ^
      uid.hashCode ^
      transactionTime.hashCode ^
      transactionImage.hashCode ^
      title.hashCode ^
      seats.hashCode ^
      theaterName.hashCode ^
      watchingTime.hashCode ^
      ticketAmount.hashCode ^
      ticketPrice.hashCode ^
      adminFee.hashCode ^
      total.hashCode;

  @override
  String toString() {
    return 'Transaction{ id: $id, '
        'uid: $uid, '
        'transactionTime: $transactionTime, '
        'transactionImage: $transactionImage, '
        'title: $title, '
        'seats: $seats, '
        'theaterName: $theaterName, '
        'watchingTime: $watchingTime, '
        'ticketAmount: $ticketAmount, '
        'ticketPrice: $ticketPrice, '
        'adminFee: $adminFee, '
        'total: $total,'
        '}';
  }

  Transaction copyWith({
    String? id,
    String? uid,
    int? transactionTime,
    String? transactionImage,
    String? title,
    List<String>? seats,
    String? theaterName,
    int? watchingTime,
    int? ticketAmount,
    int? ticketPrice,
    int? adminFee,
    int? total,
  }) {
    return Transaction(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      transactionTime: transactionTime ?? this.transactionTime,
      transactionImage: transactionImage ?? this.transactionImage,
      title: title ?? this.title,
      seats: seats ?? this.seats,
      theaterName: theaterName ?? this.theaterName,
      watchingTime: watchingTime ?? this.watchingTime,
      ticketAmount: ticketAmount ?? this.ticketAmount,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      adminFee: adminFee ?? this.adminFee,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'transactionTime': transactionTime,
      'transactionImage': transactionImage,
      'title': title,
      'seats': seats,
      'theaterName': theaterName,
      'watchingTime': watchingTime,
      'ticketAmount': ticketAmount,
      'ticketPrice': ticketPrice,
      'adminFee': adminFee,
      'total': total,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as String?,
      uid: map['uid'] as String,
      transactionTime: map['transactionTime'] as int?,
      transactionImage: map['transactionImage'] as String?,
      title: map['title'] as String,
      seats:
          (map['seats'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      theaterName: map['theaterName'] as String?,
      watchingTime: map['watchingTime'] as int?,
      ticketAmount: map['ticketAmount'] as int?,
      ticketPrice: map['ticketPrice'] as int?,
      adminFee: map['adminFee'] as int,
      total: map['total'] as int,
    );
  }
}
