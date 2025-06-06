import 'package:events_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:events_app/shared/data/datasources/credential_storage.dart';
// import 'package:events_app/shared/domain/entities/auth_status.dart';
import 'package:events_app/shared/domain/repositories/session_repository.dart';

class LoadLastUser {
  final SessionRepository _sessionRepo;
  final AuthRepository _authRepo;

  LoadLastUser(this._sessionRepo, this._authRepo);
  Future<void> call() async {
    final credentials = await _sessionRepo.getLastSessionCredentials();
    if (credentials != null) {
      final mail = credentials[CredentialStorage.keyUser]!;
      final password = credentials[CredentialStorage.keyPass]!;
      if (await _authRepo.loginWithEmail(mail, password)) {
        _sessionRepo.setCurrentUsername(mail);
      }
    }
  }
}
