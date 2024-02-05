import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flutter/material.dart';

class BottomNavBarItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final String title, icon, selectedIcon;

  const BottomNavBarItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.title,
    required this.icon,
    required this.selectedIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 25,
          height: 25,
          child: Image.asset(
            isSelected ? selectedIcon : icon,
            fit: BoxFit.contain,
          ),
        ),
        verticalSpace(4),
        Text(
          title,
          style: TextStyle(
            color: isSelected ? saffronColor : Colors.grey,
            fontSize: 9,
            fontWeight: light,
          ),
        ),
      ],
    );
  }
}
