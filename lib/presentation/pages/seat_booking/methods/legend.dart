import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/widgets/seat/seat.dart';
import 'package:flutter/material.dart';

Widget legend() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Seat(
          size: 20,
        ),
        horizontalSpace(5),
        Text(
          'Available',
          style: whiteTextStyle.copyWith(fontSize: 12),
        ),
        horizontalSpace(10),
        const Seat(
          size: 20,
          seatStatus: SeatStatus.selected,
        ),
        horizontalSpace(5),
        Text(
          'Selected',
          style: whiteTextStyle.copyWith(fontSize: 12),
        ),
        horizontalSpace(10),
        const Seat(
          size: 20,
          seatStatus: SeatStatus.reserved,
        ),
        horizontalSpace(5),
        Text(
          'Reserved',
          style: whiteTextStyle.copyWith(fontSize: 12),
        ),
      ],
    );
