import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutterv1/shared/domain/entities/auth_status.dart';
import 'package:flutterv1/shared/domain/repositories/session_repository.dart';

class LoginWithPin {
  final AuthRepository _repo;
  final SessionRepository _sessionRepo;

  LoginWithPin(this._repo, this._sessionRepo);
  Future<bool> call(String username, String pin) async {
    final ok = await _repo.loginWithPin(username, pin);
    if (ok) {
      _sessionRepo.changeSessionStatus(UserStatus.authenticated);
    }
    return ok;
  }
}
