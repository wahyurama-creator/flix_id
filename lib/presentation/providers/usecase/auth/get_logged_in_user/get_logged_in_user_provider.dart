import 'package:flix_id/domain/usecase/auth/get_logged_in_user/get_logged_in_user.dart';
import 'package:flix_id/presentation/providers/repository/authentication/authentication_provider.dart';
import 'package:flix_id/presentation/providers/repository/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_logged_in_user_provider.g.dart';

@riverpod
GetLoggedInUser getLoggedInUser(GetLoggedInUserRef ref) => GetLoggedInUser(
      authentication: ref.watch(authenticationProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );
