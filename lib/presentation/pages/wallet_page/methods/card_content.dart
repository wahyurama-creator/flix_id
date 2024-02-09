import 'package:flix_id/presentation/extensions/int_extensions.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget cardContent(WidgetRef ref) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 50, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Balance',
                style: whiteTextStyle.copyWith(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              Text(
                (ref.watch(userDataProvider).valueOrNull?.balance ?? 0)
                    .toIDRCurrencyFormat(),
                style: saffronTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
              verticalSpace(10),
              Text(
                ref.watch(userDataProvider).valueOrNull?.name ?? '',
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => ref.read(userDataProvider.notifier).topUp(
                      amount: 100000,
                    ),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.add,
                    color: saffronColor,
                  ),
                ),
              ),
              verticalSpace(4),
              Text(
                'Top Up',
                style: whiteTextStyle.copyWith(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              )
            ],
          )
        ],
      ),
    );
