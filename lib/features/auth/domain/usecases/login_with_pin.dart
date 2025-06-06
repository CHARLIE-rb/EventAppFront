import 'package:events_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:events_app/shared/domain/entities/auth_status.dart';
import 'package:events_app/shared/domain/repositories/session_repository.dart';

class LoginWithPin {
  final AuthRepository _repo;
  final SessionRepository _sessionRepo;

  LoginWithPin(this._repo, this._sessionRepo);
  Future<bool> call(String mail, String pin) async {
    final ok = await _repo.loginWithPin(mail, pin);
    if (ok) {
      _sessionRepo.changeSessionStatus(UserStatus.authenticated);
    }
    return ok;
  }
}
