import 'package:flix_id/domain/usecase/auth/logout/logout.dart';
import 'package:flix_id/presentation/providers/repository/authentication/authentication_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout_provider.g.dart';

@riverpod
Logout logout(LogoutRef ref) =>
    Logout(authentication: ref.watch(authenticationProvider));
