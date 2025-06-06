import 'package:events_app/shared/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<bool> loginWithEmail(String email, String password);
  Future<bool> loginWithPin(String mail, String pin);
  Future<bool> register(UserModel user);
}
