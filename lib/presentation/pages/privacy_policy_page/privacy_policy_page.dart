import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/widgets/back_app_bar/back_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivacyPolicyPage extends ConsumerWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackAppBar(
                  title: 'Privacy & Policy',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(40),
                Center(
                  child: Image.asset('assets/flix_logo.png', width: 150),
                ),
                verticalSpace(60),
                Text(
                  'Privacy Policy for Flix.Ids',
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                ),
                verticalSpace(12),
                Text(
                  privacyAndPolicy,
                  textAlign: TextAlign.justify,
                ),
                verticalSpace(24),
                Text(
                  'Log Files',
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                ),
                verticalSpace(12),
                Text(
                  logFiles,
                  textAlign: TextAlign.justify,
                ),
                verticalSpace(24),
                Text(
                  'Privacy Policies',
                  style: whiteTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                ),
                verticalSpace(12),
                Text(
                  policies,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
