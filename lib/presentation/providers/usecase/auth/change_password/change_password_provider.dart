import 'package:flix_id/domain/usecase/auth/change_password/change_password.dart';
import 'package:flix_id/presentation/providers/repository/authentication/authentication_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'change_password_provider.g.dart';

@riverpod
ChangePassword changePassword(ChangePasswordRef ref) =>
    ChangePassword(authentication: ref.read(authenticationProvider));
