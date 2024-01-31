import 'package:flix_id/domain/usecase/auth/upload_profile_picture/upload_profile_picture.dart';
import 'package:flix_id/presentation/providers/repository/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upload_profile_picture_provider.g.dart';

@riverpod
UploadProfilePicture uploadProfilePicture(UploadProfilePictureRef ref) =>
    UploadProfilePicture(
      userRepository: ref.watch(userRepositoryProvider),
    );
