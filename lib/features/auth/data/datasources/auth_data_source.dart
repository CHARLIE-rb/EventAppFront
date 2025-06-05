import 'package:flutterv1/shared/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<bool> loginWithEmail(String email, String password);
  Future<bool> loginWithPin(String id, String pin);
  Future<bool> register(UserModel user);
}
