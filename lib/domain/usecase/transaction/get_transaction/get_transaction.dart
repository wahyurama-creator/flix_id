import 'package:flix_id/data/repository/transaction/transaction_repository.dart';
import 'package:flix_id/domain/entity/transaction/transaction.dart';
import 'package:flix_id/domain/usecase/base_usecase.dart';
import 'package:flix_id/domain/usecase/transaction/get_transaction/get_transaction_params.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class GetTransaction
    implements
        BaseUseCase<ResultWrapper<List<Transaction>>, GetTransactionParams> {
  final TransactionRepository _transactionRepository;

  const GetTransaction({
    required TransactionRepository transactionRepository,
  }) : _transactionRepository = transactionRepository;

  @override
  Future<ResultWrapper<List<Transaction>>> call(
      GetTransactionParams params) async {
    var transactionListResult =
        await _transactionRepository.getUserTransactions(uid: params.uid);

    return switch (transactionListResult) {
      ResultSuccess(value: final transactionList) =>
        ResultWrapper.success(transactionList),
      ResultFailed(message: final message) => ResultWrapper.failed(message)
    };
  }
}
