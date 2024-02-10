import 'dart:io';

import 'package:flix_id/domain/entity/user/user.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

abstract interface class UserRepository {
  Future<ResultWrapper<User>> createUser({
    required String uid,
    required String email,
    required String name,
    String? photoUrl,
    int balance = 0,
  });

  Future<ResultWrapper<User>> getUser({required String uid});

  Future<ResultWrapper<User>> updateUser({required User user});

  Future<ResultWrapper<int>> getUserBalance({required String uid});

  Future<ResultWrapper<User>> updateUserBalance(
      {required String uid, required int balance});

  Future<ResultWrapper<User>> uploadProfilePicture(
      {required User user, required File imageFile});

  Future<ResultWrapper<User>> updateProfile({
    required User user,
    required String name,
  });
}
