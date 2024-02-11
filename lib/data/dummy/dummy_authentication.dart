import 'package:flix_id/data/repository/auth/authentication.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class DummyAuthentication implements Authentication {
  @override
  String? getLoggedInUserId() {
    throw UnimplementedError();
  }

  @override
  Future<ResultWrapper<String>> login(
      {required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));
    return const ResultFailed('Login gagal');
  }

  @override
  Future<ResultWrapper<void>> logout() {
    throw UnimplementedError();
  }

  @override
  Future<ResultWrapper<String>> register(
      {required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<ResultWrapper<String>> updatePassword({required String newPassword}) {
    throw UnimplementedError();
  }
}
