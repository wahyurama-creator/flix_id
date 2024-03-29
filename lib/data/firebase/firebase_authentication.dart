import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flix_id/data/repository/auth/authentication.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class FirebaseAuthentication implements Authentication {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuthentication({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  String? getLoggedInUserId() => _firebaseAuth.currentUser?.uid;

  @override
  Future<ResultWrapper<String>> login(
      {required String email, required String password}) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ResultWrapper.success(userCredential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return ResultWrapper.failed(e.message.toString());
    }
  }

  @override
  Future<ResultWrapper<void>> logout() async {
    try {
      await _firebaseAuth.signOut();
      return const ResultWrapper.success(null);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return ResultWrapper.failed(e.message.toString());
    }
  }

  @override
  Future<ResultWrapper<String>> register({
    required String email,
    required String password,
  }) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ResultWrapper.success(userCredential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return ResultWrapper.failed(e.message.toString());
    }
  }

  @override
  Future<ResultWrapper<String>> updatePassword(
      {required String newPassword}) async {
    try {
      User? user = _firebaseAuth.currentUser;

      String message = '';

      if (user != null) {
        await user.updatePassword(newPassword).then((value) {
          message = 'Password updated successfully';
        }).catchError((error) {
          message = error.toString();
        });
        return ResultWrapper.success(message);
      } else {
        return const ResultWrapper.failed('No user sign in');
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      return ResultWrapper.failed(e.message.toString());
    }
  }
}
