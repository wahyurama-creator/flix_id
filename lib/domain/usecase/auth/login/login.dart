import 'package:flix_id/data/repository/auth/authentication.dart';
import 'package:flix_id/data/repository/user/user_repository.dart';
import 'package:flix_id/domain/entity/user/user.dart';
import 'package:flix_id/domain/usecase/auth/login/login_params.dart';
import 'package:flix_id/domain/usecase/base_usecase.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class Login implements BaseUseCase<ResultWrapper<User>, LoginParams> {
  final Authentication authenticationRepository;
  final UserRepository userRepository;

  const Login({
    required this.authenticationRepository,
    required this.userRepository,
  });

  @override
  Future<ResultWrapper<User>> call(LoginParams params) async {
    var result = await authenticationRepository.login(
        email: params.email, password: params.password);

    if (result is ResultSuccess) {
      var userResult = await userRepository.getUser(uid: result.resultValue!);
      return switch (userResult) {
        ResultSuccess(value: final user) => ResultWrapper.success(user),
        ResultFailed(:final message) => ResultWrapper.failed(message)
      };
    } else {
      return ResultWrapper.failed(result.errorMessage!);
    }
  }
}
