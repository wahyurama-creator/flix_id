import 'package:flix_id/data/repository/user/user_repository.dart';
import 'package:flix_id/domain/usecase/auth/get_user_balance/get_user_balance_params.dart';
import 'package:flix_id/domain/usecase/base_usecase.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class GetUserBalance
    implements BaseUseCase<ResultWrapper<int>, GetUserBalanceParams> {
  final UserRepository _userRepository;

  GetUserBalance({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<ResultWrapper<int>> call(GetUserBalanceParams params) =>
      _userRepository.getUserBalance(uid: params.userId);
}
