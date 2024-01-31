import 'package:flix_id/data/firebase/firebase_authentication.dart';
import 'package:flix_id/data/repository/auth/authentication.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_provider.g.dart';

@riverpod
Authentication authentication(AuthenticationRef ref) =>
    FirebaseAuthentication();
