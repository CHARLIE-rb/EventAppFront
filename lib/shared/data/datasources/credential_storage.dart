abstract class CredentialStorage {
  static const keyUser = 'cred_user';
  static const keyPass = 'cred_pass';

  Future<void> saveCredentials(String username, String pass);
  Future<Map<String, String>?> loadCredentials();
  Future<void> clearCredentials();
}
