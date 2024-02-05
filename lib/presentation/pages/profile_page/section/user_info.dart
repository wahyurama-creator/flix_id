import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> userInfo(WidgetRef ref) => [
      verticalSpace(24),
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: ref.watch(userDataProvider).valueOrNull?.photoUrl != null
                ? NetworkImage(
                    ref.watch(userDataProvider).valueOrNull!.photoUrl!,
                  ) as ImageProvider
                : const AssetImage(
                    'assets/pp-placeholder.png',
                  ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      verticalSpace(20),
      Text(
        ref.watch(userDataProvider).valueOrNull?.name ?? '',
        style: whiteTextStyle.copyWith(
          fontSize: 16,
          fontWeight: bold,
        ),
      ),
      Text(
        ref.watch(userDataProvider).valueOrNull?.email ?? '',
        style: whiteTextStyle.copyWith(
          fontSize: 12,
          fontWeight: light,
        ),
      ),
      verticalSpace(24),
    ];
