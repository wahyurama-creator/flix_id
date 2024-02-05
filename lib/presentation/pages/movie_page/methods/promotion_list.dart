import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flutter/material.dart';

List<Widget> promotionList(List<String> promotionImageFile) => [
      Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 15, top: 24),
        child: Text(
          'Promotion',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: bold,
          ),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: promotionImageFile
              .map(
                (image) => Container(
                  width: 240,
                  height: 160,
                  margin: EdgeInsets.only(
                    left: image == promotionImageFile.first ? 24 : 10,
                    right: image == promotionImageFile.last ? 24 : 0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage('assets/$image'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      verticalSpace(24),
    ];
