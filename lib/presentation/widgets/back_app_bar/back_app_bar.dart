import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flutter/material.dart';

class BackAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const BackAppBar({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: const SizedBox(
            width: 40,
            height: 40,
            child: Icon(Icons.keyboard_arrow_left, size: 40),
          ),
        ),
        horizontalSpace(20),
        SizedBox(
          // Minus 60 for the back button and 40 for the padding
          width: MediaQuery.of(context).size.width - 60 - 40,
          child: Text(
            title,
            style: whiteTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
