// lib/features/auth/data/datasources/local/local_credential_storage.dart

import 'package:shared_preferences/shared_preferences.dart';
import 'credential_storage.dart';

class LocalCredentialStorage implements CredentialStorage {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> saveCredentials(String username, String pass) async {
    await _prefs.setString(CredentialStorage.keyUser, username);
    await _prefs.setString(CredentialStorage.keyPass, pass);
  }

  @override
  Future<Map<String, String>?> loadCredentials() async {
    final user = _prefs.getString(CredentialStorage.keyUser);
    final pass = _prefs.getString(CredentialStorage.keyPass);
    if (user == null || pass == null) return null;
    return {'user': user, 'pass': pass};
  }

  @override
  Future<void> clearCredentials() async {
    await _prefs.remove(CredentialStorage.keyUser);
    await _prefs.remove(CredentialStorage.keyPass);
  }
}
