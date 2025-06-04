import 'package:flutterv1/shared/domain/entities/user.dart';

abstract class AuthDataSource {
  Future<bool> loginWithEmail(String email, String password);
  Future<bool> loginWithPin(String id, String pin);
  Future<bool> register(User user);
}
