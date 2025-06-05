import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutterv1/shared/domain/entities/auth_status.dart';
import 'package:flutterv1/shared/domain/repositories/session_repository.dart';

class LoginWithEmail {
  final AuthRepository _repo;
  final SessionRepository _sessionRepo;

  LoginWithEmail(this._repo, this._sessionRepo);
  Future<bool> call(String email, String pass) async {
    final ok = await _repo.loginWithEmail(email, pass);
    if (ok) {
      _sessionRepo.changeSessionStatus(UserStatus.authenticated);
      _sessionRepo.saveUser(email, pass);
    }
    return ok;
  }
}
