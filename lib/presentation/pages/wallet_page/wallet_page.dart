import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/pages/wallet_page/methods/recent_transaction.dart';
import 'package:flix_id/presentation/pages/wallet_page/methods/wallet_card.dart';
import 'package:flix_id/presentation/providers/router/router_provider.dart';
import 'package:flix_id/presentation/widgets/back_app_bar/back_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletPage extends ConsumerWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                BackAppBar(
                  title: 'Wallet Page',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(24),
                walletCard(ref),
                verticalSpace(24),
                ...recentTransaction(ref),
              ],
            ),
          )
        ],
      ),
    );
  }
}
