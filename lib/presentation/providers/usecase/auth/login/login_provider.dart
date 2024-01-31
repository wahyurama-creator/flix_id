import 'package:flix_id/domain/usecase/auth/login/login.dart';
import 'package:flix_id/presentation/providers/repository/authentication/authentication_provider.dart';
import 'package:flix_id/presentation/providers/repository/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
Login login(LoginRef ref) => Login(
      authenticationRepository: ref.watch(authenticationProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );
