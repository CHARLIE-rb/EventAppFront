import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutterv1/shared/data/datasources/credential_storage.dart';
import 'package:flutterv1/shared/domain/repositories/session_repository.dart';

class LoadLastUser {
  final SessionRepository _sessionRepo;
  final AuthRepository _authRepo;

  LoadLastUser(this._sessionRepo, this._authRepo);
  Future<void> call() async {
    final credentials = await _sessionRepo.getLastSessionCredentials();
    if (credentials != null) {
      final username = credentials[CredentialStorage.keyUser]!;
      final password = credentials[CredentialStorage.keyPass]!;
      _authRepo.loginWithEmail(username, password);
      _sessionRepo.setCurrentUsername(username);
    }
  }
}
