import 'package:intl/intl.dart';

extension IntExtensions on int {

  /// Convert int to IDR currency format
  String toIDRCurrencyFormat() => NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      ).format(this);
}
