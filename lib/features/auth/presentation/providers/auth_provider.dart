import 'package:flutter/foundation.dart';
import 'package:flutterv1/shared/domain/entities/user.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_email.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_pin.dart';
import 'package:flutterv1/features/auth/domain/usecases/register_user.dart';

class AuthProvider extends ChangeNotifier {
  final LoginWithEmail _loginEmail;
  final LoginWithPin _loginPin;
  final RegisterUser _registerUser;

  AuthProvider(this._loginEmail, this._loginPin, this._registerUser);

  Future<bool> loginMail(String email, String pass) async {
    await _loginEmail(email, pass);
    return true;
  }

  Future<bool> loginPin(String username, String pin) async {
    await _loginPin(username, pin);
    return true;
  }

  void register(User u) {
    _registerUser(u);
  }
}
