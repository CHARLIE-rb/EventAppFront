// lib/features/auth/data/datasources/local/local_credential_storage.dart

import 'package:shared_preferences/shared_preferences.dart';
import '../credential_storage.dart';

class LocalCredentialStorage implements CredentialStorage {
  static const _keyUser = 'cred_user';
  static const _keyPass = 'cred_pass';

  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveCredentials(String user, String pass) async {
    await _prefs.setString(_keyUser, user);
    await _prefs.setString(_keyPass, pass);
  }

  @override
  Future<Map<String, String>?> loadCredentials() async {
    final user = _prefs.getString(_keyUser);
    final pass = _prefs.getString(_keyPass);
    if (user == null || pass == null) return null;
    return {'user': user, 'pass': pass};
  }

  @override
  Future<void> clearCredentials() async {
    await _prefs.remove(_keyUser);
    await _prefs.remove(_keyPass);
  }
}
