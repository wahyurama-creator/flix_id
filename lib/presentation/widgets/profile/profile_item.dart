import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

Widget profileItem(
  String title, {
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: whiteTextStyle.copyWith(
              fontWeight: light,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
        ],
      ),
    ),
  );
}
