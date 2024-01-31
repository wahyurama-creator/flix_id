import 'package:flix_id/data/repository/auth/authentication.dart';
import 'package:flix_id/data/repository/user/user_repository.dart';
import 'package:flix_id/domain/entity/user/user.dart';
import 'package:flix_id/domain/usecase/base_usecase.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class GetLoggedInUser implements BaseUseCase<ResultWrapper<User>, void> {
  final Authentication _authentication;
  final UserRepository _userRepository;

  const GetLoggedInUser({
    required Authentication authentication,
    required UserRepository userRepository,
  })  : _authentication = authentication,
        _userRepository = userRepository;

  @override
  Future<ResultWrapper<User>> call(void params) async {
    String? loggedId = _authentication.getLoggedInUserId();

    // Check if user logged in
    if (loggedId != null) {
      var userResult = await _userRepository.getUser(uid: loggedId);

      if (userResult.isSuccess) {
        return ResultWrapper.success(userResult.resultValue!);
      } else {
        return ResultWrapper.failed(userResult.errorMessage.toString());
      }
    }  else {
      return const ResultWrapper.failed('No user logged in');
    }
  }

}