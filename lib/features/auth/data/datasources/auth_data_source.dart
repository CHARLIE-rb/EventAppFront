import 'package:flutterv1/features/auth/domain/entities/user.dart';

abstract class AuthDataSource {
  Future<User> loginWithEmail(String email, String password);
  Future<User> loginWithPin(String id, String pin);
  Future<User> register(User user);
}
