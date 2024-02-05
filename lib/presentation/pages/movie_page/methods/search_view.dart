import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

Widget searchView(BuildContext context) => Row(
      children: [
        Container(
          // Minus 24 because of padding left and right and 90
          // for the icon button
          width: MediaQuery.of(context).size.width - 24 - 24 - 90,
          height: 50,
          margin:
              const EdgeInsets.only(left: 24, right: 10, top: 14, bottom: 24),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: const Color(0xff252836),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            style: whiteTextStyle.copyWith(
              fontSize: 13,
              color: Colors.grey.shade400,
            ),
            decoration: const InputDecoration(
              hintText: 'Search Movie...',
              hintStyle: TextStyle(
                color: Color(0xff6E7191),
              ),
              border: InputBorder.none,
              icon: Icon(
                Icons.search,
                color: Color(0xff6E7191),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 80,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              // TODO: Move to search page
            },
            child: const Center(
              child: Icon(
                Icons.search,
                color: saffronColor,
              ),
            ),
          ),
        ),
      ],
    );
