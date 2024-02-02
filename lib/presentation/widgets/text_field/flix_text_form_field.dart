import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

class FlixTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;

  const FlixTextFormField({
    super.key,
    required this.labelText,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: whiteTextStyle.copyWith(fontSize: 14),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade800,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ghostWhiteColor,
          ),
        ),
      ),
    );
  }
}
