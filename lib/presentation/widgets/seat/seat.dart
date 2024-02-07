import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

class Seat extends StatelessWidget {
  final int? number;
  final SeatStatus seatStatus;
  final double size;
  final VoidCallback? onTap;

  const Seat({
    super.key,
    this.number,
    this.seatStatus = SeatStatus.available,
    this.size = 30,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: seatStatus == SeatStatus.available
              ? Colors.white
              : seatStatus == SeatStatus.reserved
                  ? Colors.grey
                  : saffronColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            number?.toString() ?? '',
            style: whiteTextStyle.copyWith(
              color: backgroundColor,
              fontWeight: bold,
            ),
          ),
        ),
      ),
    );
  }
}

enum SeatStatus {
  available,
  reserved,
  selected,
}
