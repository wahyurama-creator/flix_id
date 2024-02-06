import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double width, height;
  final String title;
  final Color? backgroundColor, textColor;
  final VoidCallback? onPressed;

  const PrimaryButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height = 45,
    this.backgroundColor = Colors.black,
    this.textColor = saffronColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
