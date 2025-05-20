import 'package:flutterv1/src/data/users_data.dart';

import '../models/user.dart';

class AuthService {
  final List<User> _users = mockUsers;
  User? _current = mockUsers.firstWhere((u) => u.id == 'u1');
  // User? _current;
  User? get currentUser => _current;

  bool loginWithEmail(String email, String password) {
    User? user;
    try {
      user = _users.firstWhere(
        (u) => u.email == email && u.password == password,
      );
    } catch (e) {
      user = null;
    }
    if (user != null) {
      _current = user;
      return true;
    }
    return false;
  }

  bool loginWithPin(String id, String pin) {
    User? user;
    try {
      user = _users.firstWhere((u) => u.id == id && u.pin == pin);
    } catch (e) {
      user = null;
    }
    if (user != null) {
      _current = user;
      return true;
    }
    return false;
  }

  // Para registro en prueba (añade a la lista)
  void register(User newUser) {
    _users.add(newUser);
  }

  void logout() {
    _current = null;
  }
}
