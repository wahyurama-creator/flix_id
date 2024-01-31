import 'package:flix_id/domain/usecase/transaction/top_up/top_up.dart';
import 'package:flix_id/presentation/providers/repository/transaction_repository/transaction_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'top_up_provider.g.dart';

@riverpod
TopUp topUp(TopUpRef ref) => TopUp(
      transactionRepository: ref.watch(transactionRepositoryProvider),
    );