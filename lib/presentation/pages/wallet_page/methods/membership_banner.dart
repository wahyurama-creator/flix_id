import 'dart:math';

import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

Widget membershipBanner() => Align(
      alignment: Alignment.centerRight,
      child: Transform.rotate(
        angle: pi / 2,
        origin: const Offset(17.5, 17.5),
        child: Container(
          width: 100,
          height: 30,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            gradient: LinearGradient(
              colors: [
                Color(0xFF966120),
                Color(0xFFBD8939),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Center(
            child: Text(
              'PRIORITY',
              style: whiteTextStyle.copyWith(
                fontWeight: bold,
                color: backgroundColor,
              ),
            ),
          ),
        ),
      ),
    );
