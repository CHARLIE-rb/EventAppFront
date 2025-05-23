import 'package:flutter/foundation.dart';
import 'package:flutterv1/features/auth/data/datasources/auth_service.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/features/auth/domain/usecases/get_current_user.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_email.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_pin.dart';

class AuthProvider extends ChangeNotifier {
  // final AuthService _auth = AuthService();
  final LoginWithEmail _loginEmail;
  final LoginWithPin _loginPin;
  final GetCurrentUser _getUser;

  User? get user => _getUser();
  bool get isLoggedIn => user != null;

  AuthProvider(this._loginEmail, this._loginPin, this._getUser);

  Future<bool> login(String email, String pass) async {
    try {
      await _loginEmail(email, pass);
      if (ok) notifyListeners();
      return ok;
    } catch (_) {
      return false;
    }
  }
  // bool loginMail(String email, String password) {
  //   final ok = _auth.loginWithEmail(email, password);
  //   if (ok) notifyListeners();
  //   return ok;
  // }

  // bool loginPin(String pin) {
  //   final ok = _auth.loginWithPin(user!.id, pin);
  //   if (ok) notifyListeners();
  //   return ok;
  // }

  // void logout() {
  //   _auth.logout();
  //   notifyListeners();
  // }

  // void register(User u) {
  //   _auth.register(u);
  //   // no autologin en este ejemplo, o sí si quieres:
  //   //_auth._current = u; notifyListeners();
  // }
}
