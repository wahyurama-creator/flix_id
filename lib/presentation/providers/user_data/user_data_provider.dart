import 'dart:io';

import 'package:flix_id/domain/entity/user/user.dart';
import 'package:flix_id/domain/usecase/auth/get_logged_in_user/get_logged_in_user.dart';
import 'package:flix_id/domain/usecase/auth/login/login.dart';
import 'package:flix_id/domain/usecase/auth/login/login_params.dart';
import 'package:flix_id/domain/usecase/auth/register/register.dart';
import 'package:flix_id/domain/usecase/auth/register/register_params.dart';
import 'package:flix_id/domain/usecase/auth/upload_profile_picture/upload_profile_picture.dart';
import 'package:flix_id/domain/usecase/auth/upload_profile_picture/upload_profile_picture_params.dart';
import 'package:flix_id/domain/usecase/transaction/top_up/top_up.dart';
import 'package:flix_id/domain/usecase/transaction/top_up/top_up_params.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';
import 'package:flix_id/presentation/providers/movie/now_playing/now_playing_provider.dart';
import 'package:flix_id/presentation/providers/movie/up_coming/up_coming_provider.dart';
import 'package:flix_id/presentation/providers/transaction_data/transaction_data_provider.dart';
import 'package:flix_id/presentation/providers/usecase/auth/logout/logout_provider.dart';
import 'package:flix_id/presentation/providers/usecase/auth/register/register_provider.dart';
import 'package:flix_id/presentation/providers/usecase/auth/upload_profile_picture/upload_profile_picture_provider.dart';
import 'package:flix_id/presentation/providers/usecase/transaction/top_up/top_up_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../usecase/auth/get_logged_in_user/get_logged_in_user_provider.dart';
import '../usecase/auth/login/login_provider.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);
    var userResult = await getLoggedInUser(null);

    switch (userResult) {
      case ResultSuccess(value: final user):
        _getMovies();
        return user;
      case ResultFailed(message: final _):
        return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    Login login = ref.read(loginProvider);

    var loginResult =
        await login(LoginParams(email: email, password: password));

    switch (loginResult) {
      case ResultSuccess(value: final user):
        _getMovies();
        state = AsyncData(user);
      case ResultFailed(message: final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String? photoUrl,
  }) async {
    state = const AsyncLoading();
    Register register = ref.read(registerProvider);

    var registerResult = await register(
      RegisterParams(
        email: email,
        password: password,
        name: name,
        photoUrl: photoUrl,
      ),
    );

    switch (registerResult) {
      case ResultSuccess(value: final user):
        _getMovies();
        state = AsyncData(user);
      case ResultFailed(message: final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> refreshUserData() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);
    var result = await getLoggedInUser(null);

    if (result case ResultSuccess(value: final user)) {
      state = AsyncData(user);
    }
  }

  Future<void> logout() async {
    var logout = ref.read(logoutProvider);
    var result = await logout(null);

    switch (result) {
      case ResultSuccess(value: final _):
        state = const AsyncData(null);
      case ResultFailed(message: final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }

  Future<void> topUp({required int amount}) async {
    TopUp topUp = ref.read(topUpProvider);
    String? userId = state.valueOrNull?.uid;

    if (userId != null) {
      var result = await topUp(TopUpParams(amount: amount, userId: userId));

      if (result.isSuccess) {
        refreshUserData();
        // ignore: avoid_manual_providers_as_generated_provider_dependency
        ref.read(transactionDataProvider.notifier).refreshTransactionData();
      }
    }
  }

  Future<void> uploadProfilePicture(
      {required User user, required File imageFile}) async {
    UploadProfilePicture uploadProfilePicture =
        ref.read(uploadProfilePictureProvider);

    var result = await uploadProfilePicture(
      UploadProfilePictureParams(imageFile: imageFile, user: user),
    );

    if (result case ResultSuccess(value: final user)) {
      state = AsyncData(user);
    }
  }

  void _getMovies() {
    ref.read(nowPlayingProvider.notifier).getMovies();
    ref.read(upComingProvider.notifier).getMovies();
  }
}
