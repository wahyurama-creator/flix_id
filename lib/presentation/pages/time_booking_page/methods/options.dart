import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/widgets/selectable_card/selectable_card.dart';
import 'package:flutter/material.dart';

List<Widget> options<T>({
  required String title,
  required List<T> options,
  required T? selectedItem,
  required String Function(T object)? itemToString,
  bool Function(T object)? isOptionEnabled,
  required Function(T object) onTap,
}) =>
    [
      Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Text(
          title,
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: bold,
          ),
        ),
      ),
      verticalSpace(10),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: options
              .map(
                (element) => Padding(
                  padding: EdgeInsets.only(
                      left: element == options.first ? 24 : 0,
                      right: element == options.last ? 24 : 10),
                  child: SelectableCard(
                    text: itemToString != null
                        ? itemToString(element)
                        : element.toString(),
                    isSelected: element == selectedItem,
                    isEnabled: isOptionEnabled?.call(element) ?? true,
                    onTap: () => onTap(element),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ];
