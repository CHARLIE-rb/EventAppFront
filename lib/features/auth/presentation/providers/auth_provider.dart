import 'package:flutter/foundation.dart';
import 'package:flutterv1/shared/domain/entities/user.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_email.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_pin.dart';
import 'package:flutterv1/features/auth/domain/usecases/register_user.dart';

class AuthProvider extends ChangeNotifier {
  final LoginWithEmail _loginEmail;
  final LoginWithPin _loginPin;
  final RegisterUser _registerUser;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  AuthProvider(this._loginEmail, this._loginPin, this._registerUser);

  Future<bool> loginMail(String email, String pass) async {
    try {
      _errorMessage = null;
      await _loginEmail(email, pass);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> loginPin(String username, String pin) async {
    try {
      _errorMessage = null;
      await _loginPin(username, pin);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  void register(User u) {
    _registerUser(u);
  }
}
