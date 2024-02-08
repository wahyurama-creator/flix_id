import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flix_id/data/firebase/firebase_user_repository.dart';
import 'package:flix_id/data/repository/transaction/transaction_repository.dart';
import 'package:flix_id/domain/entity/transaction/transaction.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class FirebaseTransactionRepository implements TransactionRepository {
  final firestore.FirebaseFirestore _firebaseFirestore;

  FirebaseTransactionRepository({
    firestore.FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore =
            firebaseFirestore ?? firestore.FirebaseFirestore.instance;

  @override
  Future<ResultWrapper<Transaction>> createTransaction({
    required Transaction transaction,
  }) async {
    firestore.CollectionReference transactions =
        _firebaseFirestore.collection('transactions');

    try {
      // Get the current user balance
      var currentBalance =
          await FirebaseUserRepository().getUserBalance(uid: transaction.uid);

      if (currentBalance.isSuccess) {
        int previousBalance = currentBalance.resultValue!;

        // Check if the user has enough balance to make the transaction
        if (previousBalance - transaction.total >= 0) {
          await transactions.doc(transaction.id).set(transaction.toMap());
          var resultTransaction = await transactions.doc(transaction.id).get();

          // Check if the transaction data has been created and update balance
          if (resultTransaction.exists) {
            await FirebaseUserRepository().updateUserBalance(
              uid: transaction.uid,
              balance: previousBalance - transaction.total,
            );
            return ResultWrapper.success(
              Transaction.fromMap(
                  resultTransaction.data() as Map<String, dynamic>),
            );
          } else {
            return const ResultWrapper.failed(
              'Failed to create transaction data',
            );
          }
        } else {
          return const ResultWrapper.failed('Insufficient balance');
        }
      } else {
        return ResultWrapper.failed(
          'Failed to create transaction: ${currentBalance.errorMessage}',
        );
      }
    } catch (e) {
      return ResultWrapper.failed('Failed to create transaction: $e');
    }
  }

  @override
  Future<ResultWrapper<List<Transaction>>> getUserTransactions({
    required String uid,
  }) async {
    firestore.CollectionReference<Map<String, dynamic>> transactions =
        _firebaseFirestore.collection('transactions');

    try {
      var result = await transactions.where('uid', isEqualTo: uid).get();

      // Check if the user has any transaction data
      if (result.docs.isNotEmpty) {
        List<Transaction> transactions =
            result.docs.map((e) => Transaction.fromMap(e.data())).toList();

        return ResultWrapper.success(transactions);
      } else {
        return const ResultWrapper.success([]);
      }
    } catch (e) {
      return ResultWrapper.failed('Failed to get user transactions: $e');
    }
  }
}
