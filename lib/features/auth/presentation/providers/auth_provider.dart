import 'package:flutter/foundation.dart';
import 'package:events_app/shared/domain/entities/user.dart';
import 'package:events_app/features/auth/domain/usecases/login_with_email.dart';
import 'package:events_app/features/auth/domain/usecases/login_with_pin.dart';
import 'package:events_app/features/auth/domain/usecases/register_user.dart';

class AuthProvider extends ChangeNotifier {
  final LoginWithEmail _loginEmail;
  final LoginWithPin _loginPin;
  final RegisterUser _registerUser;

  AuthProvider(this._loginEmail, this._loginPin, this._registerUser);

  Future<bool> loginMail(String email, String pass) async {
    return _loginEmail(email, pass);
  }

  Future<bool> loginPin(String mail, String pin) async {
    return _loginPin(mail, pin);
  }

  void register(User u) {
    _registerUser(u);
  }
}
