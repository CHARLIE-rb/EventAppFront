import 'package:events_app/shared/domain/entities/auth_status.dart';
import 'package:events_app/shared/domain/repositories/session_repository.dart';

class GetCurrentSessionstatus {
  final SessionRepository _repo;

  GetCurrentSessionstatus(this._repo);

  UserStatus call() {
    return _repo.getSessionStatus();
  }
}
