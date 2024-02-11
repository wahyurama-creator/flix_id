import 'dart:async';

import 'package:flix_id/domain/wrapper/result_wrapper.dart';

abstract interface class Authentication {
  Future<ResultWrapper<String>> register(
      {required String email, required String password});

  Future<ResultWrapper<String>> login(
      {required String email, required String password});

  Future<ResultWrapper<void>> logout();

  String? getLoggedInUserId();

  Future<ResultWrapper<String>> updatePassword({
    required String newPassword,
  });
}
