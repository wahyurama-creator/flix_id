import 'package:flix_id/presentation/pages/wallet_page/methods/card_content.dart';
import 'package:flix_id/presentation/pages/wallet_page/methods/membership_banner.dart';
import 'package:flix_id/presentation/pages/wallet_page/methods/wallet_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget walletCard(WidgetRef ref) => Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          walletPattern(),
          membershipBanner(),
          cardContent(ref),
        ],
      ),
    );
