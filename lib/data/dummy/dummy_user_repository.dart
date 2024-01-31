import 'dart:io';

import 'package:flix_id/data/repository/user/user_repository.dart';
import 'package:flix_id/domain/entity/user/user.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class DummyUserRepository implements UserRepository {
  @override
  Future<ResultWrapper<User>> createUser(
      {required String uid,
      required String email,
      required String name,
      String? photoUrl,
      int balance = 0}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<ResultWrapper<User>> getUser({required String uid}) async {
    await Future.delayed(const Duration(seconds: 1));
    return ResultWrapper.success(
        User(uid: uid, email: 'dummy@mail.com', name: 'Dummy'));
  }

  @override
  Future<ResultWrapper<int>> getUserBalance({required String uid}) {
    // TODO: implement getUserBalance
    throw UnimplementedError();
  }

  @override
  Future<ResultWrapper<User>> updateUser({required User user}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<ResultWrapper<User>> updateUserBalance(
      {required String uid, required int balance}) {
    // TODO: implement updateUserBalance
    throw UnimplementedError();
  }

  @override
  Future<ResultWrapper<User>> uploadProfilePicture(
      {required User user, required File imageFile}) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
