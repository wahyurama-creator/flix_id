import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flutter/material.dart';

Widget rowItemDetail({
  required String title,
  required String description,
  required double width,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: whiteTextStyle.copyWith(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: light,
              ),
            ),
          ),
          horizontalSpace(20),
          SizedBox(
            width: width - 110 - 20,
            child: Text(
              description,
              style: whiteTextStyle.copyWith(
                fontSize: 13,
                fontWeight: bold,
              ),
            ),
          ),
        ],
      ),
    );
