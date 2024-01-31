import 'package:flix_id/data/repository/user/user_repository.dart';
import 'package:flix_id/domain/entity/user/user.dart';
import 'package:flix_id/domain/usecase/auth/upload_profile_picture/upload_profile_picture_params.dart';
import 'package:flix_id/domain/usecase/base_usecase.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class UploadProfilePicture
    implements BaseUseCase<ResultWrapper<User>, UploadProfilePictureParams> {
  final UserRepository _userRepository;

  UploadProfilePicture({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<ResultWrapper<User>> call(UploadProfilePictureParams params) =>
      _userRepository.uploadProfilePicture(
          user: params.user, imageFile: params.imageFile);
}
