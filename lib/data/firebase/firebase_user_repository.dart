import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flix_id/data/repository/user/user_repository.dart';
import 'package:flix_id/domain/entity/user/user.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';
import 'package:path/path.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseUserRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<ResultWrapper<User>> createUser({
    required String uid,
    required String email,
    required String name,
    String? photoUrl,
    int balance = 0,
  }) async {
    CollectionReference<Map<String, dynamic>> users =
        _firebaseFirestore.collection('users');

    await users.doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'balance': balance,
    });

    DocumentSnapshot<Map<String, dynamic>> userData =
        await users.doc(uid).get();
    if (userData.exists) {
      User user = User.fromMap(userData.data()!);
      return ResultWrapper.success(user);
    } else {
      return const ResultWrapper.failed('Failed to create user');
    }
  }

  @override
  Future<ResultWrapper<User>> getUser({required String uid}) async {
    DocumentReference<Map<String, dynamic>> userReference =
        _firebaseFirestore.doc('users/$uid');

    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await userReference.get();

    if (userSnapshot.exists) {
      User user = User.fromMap(userSnapshot.data()!);
      return ResultWrapper.success(user);
    } else {
      return const ResultWrapper.failed('User not found');
    }
  }

  @override
  Future<ResultWrapper<int>> getUserBalance({required String uid}) async {
    DocumentReference<Map<String, dynamic>> userReference =
        _firebaseFirestore.doc('users/$uid');

    DocumentSnapshot<Map<String, dynamic>> userData = await userReference.get();
    if (userData.exists) {
      User user = User.fromMap(userData.data()!);
      return ResultWrapper.success(user.balance);
    } else {
      return const ResultWrapper.failed('User not found');
    }
  }

  @override
  Future<ResultWrapper<User>> updateUser({required User user}) async {
    DocumentReference<Map<String, dynamic>> userReference =
        _firebaseFirestore.doc('users/${user.uid}');

    await userReference.update(user.toMap());

    DocumentSnapshot<Map<String, dynamic>> userData = await userReference.get();
    if (userData.exists) {
      User user = User.fromMap(userData.data()!);
      return ResultWrapper.success(user);
    } else {
      return const ResultWrapper.failed('Failed to update user');
    }
  }

  @override
  Future<ResultWrapper<User>> updateUserBalance({
    required String uid,
    required int balance,
  }) async {
    DocumentReference<Map<String, dynamic>> userReference =
        _firebaseFirestore.doc('users/$uid');
    DocumentSnapshot<Map<String, dynamic>> userData = await userReference.get();

    if (userData.exists) {
      await userReference.update({'balance': balance});
      DocumentSnapshot<Map<String, dynamic>> updatedUserData =
          await userReference.get();

      if (updatedUserData.exists) {
        User user = User.fromMap(updatedUserData.data()!);

        if (user.balance == balance) {
          return ResultWrapper.success(user);
        } else {
          return const ResultWrapper.failed(
              'Failed to retrieve update user balance');
        }
      } else {
        return const ResultWrapper.failed(
            'Failed to updated user balance');
      }
    } else {
      return const ResultWrapper.failed('User not found');
    }
  }

  @override
  Future<ResultWrapper<User>> uploadProfilePicture({
    required User user,
    required File imageFile,
  }) async {
    String fileName = basename(imageFile.path);
    Reference reference = FirebaseStorage.instance.ref().child(fileName);

    try {
      await reference.putFile(imageFile);
      String downloadUrl = await reference.getDownloadURL();

      var updateResult = await updateUser(
        user: user.copyWith(photoUrl: downloadUrl),
      );

      if (updateResult.isSuccess) {
        return ResultWrapper.success(updateResult.resultValue!);
      } else {
        return ResultWrapper.failed(updateResult.errorMessage.toString());
      }
    } catch (e) {
      return ResultWrapper.failed('Failed to upload profile picture: $e');
    }
  }
}
