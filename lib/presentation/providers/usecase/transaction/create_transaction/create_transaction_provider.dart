import 'package:flix_id/domain/usecase/transaction/create_transaction/create_transaction.dart';
import 'package:flix_id/presentation/providers/repository/transaction_repository/transaction_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_transaction_provider.g.dart';

@riverpod
CreateTransaction createTransaction(CreateTransactionRef ref) =>
    CreateTransaction(
      transactionRepository: ref.watch(transactionRepositoryProvider),
    );
