import 'package:flutter/foundation.dart';
import 'package:flutterv1/features/auth/domain/entities/auth_status.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/features/auth/domain/usecases/get_current_user.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_email.dart';
import 'package:flutterv1/features/auth/domain/usecases/login_with_pin.dart';
import 'package:flutterv1/features/auth/domain/usecases/logout.dart';
import 'package:flutterv1/features/auth/domain/usecases/register_user.dart';

class AuthProvider extends ChangeNotifier {
  final LoginWithEmail _loginEmail;
  final LoginWithPin _loginPin;
  final GetCurrentUser _getUser;
  final RegisterUser _registerUser;
  final Logout _logout;
  AuthStatus _authStatus = AuthStatus.uninitialized;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  User? get user => _getUser();
  AuthStatus get authStatus => _authStatus;

  AuthProvider(
    this._loginEmail,
    this._loginPin,
    this._getUser,
    this._registerUser,
    this._logout,
  ) {
    _load();
  }

  Future<void> _load() async {
    final user = _getUser();
    if (user != null) {
      _authStatus = AuthStatus.pinRequired;
    } else {
      _authStatus = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> loginMail(String email, String pass) async {
    try {
      _errorMessage = null;
      await _loginEmail(email, pass);
      final ok = user != null;
      if (ok) notifyListeners();
      return ok;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  Future<bool> loginPin(String pin) async {
    try {
      _errorMessage = null;
      await _loginPin(user!.id, pin);
      final ok = user != null;
      if (ok) notifyListeners();
      return ok;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }

  void logout() {
    _logout();
    notifyListeners();
  }

  void register(User u) {
    _registerUser(u);
  }
}
