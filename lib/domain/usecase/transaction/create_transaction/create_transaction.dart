import 'package:flix_id/data/repository/transaction/transaction_repository.dart';
import 'package:flix_id/domain/usecase/base_usecase.dart';
import 'package:flix_id/domain/usecase/transaction/create_transaction/create_transaction_params.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class CreateTransaction
    implements BaseUseCase<ResultWrapper<void>, CreateTransactionParams> {
  final TransactionRepository _transactionRepository;

  const CreateTransaction({
    required TransactionRepository transactionRepository,
  }) : _transactionRepository = transactionRepository;

  @override
  Future<ResultWrapper<void>> call(CreateTransactionParams params) async {
    int transactionTime = DateTime.now().millisecondsSinceEpoch;

    var resultTransaction = await _transactionRepository.createTransaction(
        transaction: params.transaction.copyWith(
      transactionTime: transactionTime,
      id: (params.transaction.id == null)
          ? 'flx-$transactionTime-${params.transaction.uid}'
          : params.transaction.id,
    ));

    return switch (resultTransaction) {
      ResultSuccess() => const ResultWrapper.success(null),
      ResultFailed(:final message) => ResultWrapper.failed(message)
    };
  }
}
