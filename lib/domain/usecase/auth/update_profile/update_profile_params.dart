import 'package:flix_id/domain/entity/user/user.dart';

class UpdateProfileParams {
  final User user;
  final String name;

  const UpdateProfileParams({
    required this.user,
    required this.name,
  });
}
