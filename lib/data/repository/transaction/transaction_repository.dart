import 'package:flix_id/domain/entity/transaction/transaction.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

abstract interface class TransactionRepository {
  Future<ResultWrapper<Transaction>> createTransaction(
      {required Transaction transaction});

  Future<ResultWrapper<List<Transaction>>> getUserTransactions(
      {required String uid});
}
