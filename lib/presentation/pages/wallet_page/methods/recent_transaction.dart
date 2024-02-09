import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flix_id/presentation/misc/methods.dart';
import 'package:flix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_id/presentation/widgets/transaction/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> recentTransaction(WidgetRef ref) => [
      SizedBox(
        width: double.infinity,
        child: Text(
          'Recent Transaction',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: bold,
          ),
        ),
      ),
      verticalSpace(24),
      ...ref.watch(transactionDataProvider).when(
            data: (transactions) => (transactions
                  ..sort((a, b) =>
                      -a.transactionTime!.compareTo(b.transactionTime!)))
                .map(
                  (transaction) => TransactionCard(
                    transaction: transaction,
                  ),
                )
                .toList(),
            error: (error, _) => [],
            loading: () => [const CircularProgressIndicator()],
          ),
    ];
