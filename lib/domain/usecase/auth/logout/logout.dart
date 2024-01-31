import 'package:flix_id/data/repository/auth/authentication.dart';
import 'package:flix_id/domain/usecase/base_usecase.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class Logout implements BaseUseCase<void, void> {
  final Authentication _authentication;

  Logout({required Authentication authentication})
      : _authentication = authentication;

  @override
  Future<ResultWrapper<void>> call(void _) {
    return _authentication.logout();
  }
}
