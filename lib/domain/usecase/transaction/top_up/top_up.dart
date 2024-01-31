import 'package:flix_id/data/repository/transaction/transaction_repository.dart';
import 'package:flix_id/domain/entity/transaction/transaction.dart';
import 'package:flix_id/domain/usecase/base_usecase.dart';
import 'package:flix_id/domain/usecase/transaction/create_transaction/create_transaction.dart';
import 'package:flix_id/domain/usecase/transaction/create_transaction/create_transaction_params.dart';
import 'package:flix_id/domain/usecase/transaction/top_up/top_up_params.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class TopUp implements BaseUseCase<ResultWrapper<void>, TopUpParams> {
  final TransactionRepository _transactionRepository;

  TopUp({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  @override
  Future<ResultWrapper<void>> call(TopUpParams params) async {
    CreateTransaction createTransaction =
        CreateTransaction(transactionRepository: _transactionRepository);

    int transactionTime = DateTime.now().millisecondsSinceEpoch;

    var createTransactionResult = await createTransaction(
      CreateTransactionParams(
        transaction: Transaction(
          id: 'flx-tp-$transactionTime-${params.userId}',
          uid: params.userId,
          title: 'Top Up',
          adminFee: 0,
          total: -params.amount,
          transactionTime: transactionTime,
        ),
      ),
    );

    return switch (createTransactionResult) {
      ResultSuccess(value: _) => const ResultWrapper.success(null),
      ResultFailed(message: _) =>
        const ResultWrapper.failed('Failed to top up, please try again later')
    };
  }
}
