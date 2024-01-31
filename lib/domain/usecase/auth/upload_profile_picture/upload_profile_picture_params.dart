import 'dart:io';

import 'package:flix_id/domain/entity/user/user.dart';

class UploadProfilePictureParams {
  final File imageFile;
  final User user;

  const UploadProfilePictureParams({
    required this.imageFile,
    required this.user,
  });
}
