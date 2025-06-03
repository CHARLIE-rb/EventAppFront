abstract class CredentialStorage {
  Future<void> saveCredentials(String user, String pass);
  Future<Map<String, String>?> loadCredentials();
  Future<void> clearCredentials();
}
