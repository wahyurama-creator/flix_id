import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

class SelectableCard extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isEnabled;

  const SelectableCard({
    super.key,
    required this.text,
    this.onTap,
    this.isSelected = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? saffronColor.withOpacity(0.3) : null,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? saffronColor : Colors.grey,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: whiteTextStyle.copyWith(
              color: isEnabled ? ghostWhiteColor : Colors.grey,
              fontWeight: isSelected ? bold : light,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
