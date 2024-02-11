import 'package:flix_id/data/repository/auth/authentication.dart';
import 'package:flix_id/domain/usecase/auth/change_password/change_password_params.dart';
import 'package:flix_id/domain/usecase/base_usecase.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class ChangePassword
    implements BaseUseCase<ResultWrapper<String>, ChangePasswordParams> {
  final Authentication _authentication;

  const ChangePassword({
    required Authentication authentication,
  }) : _authentication = authentication;

  @override
  Future<ResultWrapper<String>> call(ChangePasswordParams params) async {
    var result =
        await _authentication.updatePassword(newPassword: params.newPassword);

    if (result is ResultSuccess) {
      return ResultWrapper.success(result.resultValue!);
    } else {
      return ResultWrapper.failed(result.errorMessage.toString());
    }
  }
}
