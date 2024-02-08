import 'package:flix_id/domain/entity/transaction/transaction.dart';
import 'package:flix_id/domain/entity/user/user.dart';
import 'package:flix_id/domain/usecase/transaction/get_transaction/get_transaction.dart';
import 'package:flix_id/domain/usecase/transaction/get_transaction/get_transaction_params.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';
import 'package:flix_id/presentation/providers/usecase/transaction/get_transaction/get_transaction_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_data_provider.g.dart';

@Riverpod(keepAlive: true)
class TransactionData extends _$TransactionData {
  @override
  Future<List<Transaction>> build() async {
    User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      state = const AsyncLoading();
      GetTransaction getTransaction = ref.read(getTransactionProvider);

      var result = await getTransaction(GetTransactionParams(uid: user.uid));

      if (result case ResultSuccess(value: final transactions)) {
        return transactions;
      }
    }

    return const [];
  }

  Future<void> refreshTransactionData() async {
    User? user = ref.read(userDataProvider).valueOrNull;

    if (user != null) {
      state = const AsyncLoading();

      GetTransaction getTransaction = ref.read(getTransactionProvider);
      var result = getTransaction(GetTransactionParams(uid: user.uid));

      switch (result) {
        case ResultSuccess(value: final transactions):
          state = AsyncData(transactions);
        case ResultFailed(:final message):
          state = AsyncError(FlutterError(message), StackTrace.current);
          state = AsyncData(state.valueOrNull ?? const []);
      }
    }
  }
}
