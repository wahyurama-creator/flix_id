import 'package:flix_id/presentation/extensions/int_extensions.dart';
import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget userInfo(WidgetRef ref) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: ref.watch(userDataProvider).valueOrNull?.photoUrl != null
                    ? NetworkImage(
                        ref.watch(userDataProvider).value!.photoUrl!,
                      ) as ImageProvider
                    : const AssetImage(
                        'assets/pp-placeholder.png',
                      ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          horizontalSpace(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_getGreeting()}, '
                '${ref.watch(userDataProvider).when(
                      data: (user) => user?.name.split(' ').first ?? '',
                      error: (error, stackTrace) => '',
                      loading: () => 'Loading...',
                    )}!',
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
              Text(
                'Let\'s find your favorite movie!',
                style: whiteTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: light,
                ),
              ),
              verticalSpace(5),
              GestureDetector(
                onTap: () {
                  ref.read(routerProvider).pushNamed('wallet');
                },
                child: Row(
                  children: [
                    SizedBox(
                      height: 18,
                      width: 18,
                      child: Image.asset('assets/wallet.png'),
                    ),
                    horizontalSpace(10),
                    Text(
                      ref.watch(userDataProvider).when(
                            data: (user) =>
                                (user?.balance ?? 0).toIDRCurrencyFormat(),
                            error: (error, stackTrace) => 'IDR 0',
                            loading: () => 'Loading...',
                          ),
                      style: whiteTextStyle.copyWith(
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

String _getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 18) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}
