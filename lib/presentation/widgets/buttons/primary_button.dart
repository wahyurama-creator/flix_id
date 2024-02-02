import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double width, height;
  final String title;
  final VoidCallback? onPressed;

  const PrimaryButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height = 45,
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
