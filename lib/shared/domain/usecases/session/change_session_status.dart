import 'package:events_app/shared/domain/entities/auth_status.dart';
import 'package:events_app/shared/domain/repositories/session_repository.dart';

class ChangeSessionstatus {
  final SessionRepository _repo;
  ChangeSessionstatus(this._repo);
  void call(UserStatus userStatus) => _repo.changeSessionStatus(userStatus);
}
