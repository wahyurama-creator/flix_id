import 'package:flix_id/data/repository/user/user_repository.dart';
import 'package:flix_id/domain/entity/user/user.dart';
import 'package:flix_id/domain/usecase/auth/update_profile/update_profile_params.dart';
import 'package:flix_id/domain/usecase/base_usecase.dart';
import 'package:flix_id/domain/wrapper/result_wrapper.dart';

class UpdateProfile
    implements BaseUseCase<ResultWrapper<User>, UpdateProfileParams> {
  final UserRepository _userRepository;

  UpdateProfile({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<ResultWrapper<User>> call(UpdateProfileParams params) =>
      _userRepository.updateProfile(
        user: params.user,
        name: params.name,
      );
}
