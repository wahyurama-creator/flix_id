import 'package:flix_id/domain/usecase/auth/update_profile/update_profile.dart';
import 'package:flix_id/presentation/providers/repository/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_profile_provider.g.dart';

@riverpod
UpdateProfile updateProfile(UpdateProfileRef ref) => UpdateProfile(
      userRepository: ref.watch(userRepositoryProvider),
    );
