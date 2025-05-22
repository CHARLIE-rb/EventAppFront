import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _auth = AuthService();
  User? get user => _auth.currentUser;
  bool get isLoggedIn => user != null;

  bool loginMail(String email, String password) {
    final ok = _auth.loginWithEmail(email, password);
    if (ok) notifyListeners();
    return ok;
  }

  bool loginPin(String pin) {
    final ok = _auth.loginWithPin(user!.id, pin);
    if (ok) notifyListeners();
    return ok;
  }

  void logout() {
    _auth.logout();
    notifyListeners();
  }

  void register(User u) {
    _auth.register(u);
    // no autologin en este ejemplo, o sí si quieres:
    //_auth._current = u; notifyListeners();
  }
}
