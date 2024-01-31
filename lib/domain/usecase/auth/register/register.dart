import 'package:flix_id/data/repository/auth/authentication.dart';
import 'package:flix_id/data/repository/user/user_repository.dart';
import 'package:flix_id/domain/entity/user/user.dart';
import 'package:flix_id/domain/usecase/auth/register/register_params.dart';
import 'package:flix_id/domain/usecase/base_usecase.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class Register implements BaseUseCase<ResultWrapper<User>, RegisterParams> {
  final Authentication _authentication;
  final UserRepository _userRepository;

  const Register({
    required Authentication authentication,
    required UserRepository userRepository,
  })  : _authentication = authentication,
        _userRepository = userRepository;

  @override
  Future<ResultWrapper<User>> call(RegisterParams params) async {
    var uidResult = await _authentication.register(
        email: params.email, password: params.password);

    // Check if the result uid is a success
    if (uidResult is ResultSuccess) {
      var resultUser = await _userRepository.createUser(
        uid: uidResult.resultValue!,
        email: params.email,
        name: params.name,
        photoUrl: params.photoUrl,
      );

      // Check if the result create user is a success
      if (resultUser is ResultSuccess) {
        return ResultWrapper.success(resultUser.resultValue!);
      } else {
        return ResultWrapper.failed(resultUser.errorMessage.toString());
      }
    } else {
      return ResultWrapper.failed(uidResult.errorMessage.toString());
    }
  }
}
