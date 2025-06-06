import 'package:events_app/shared/domain/entities/current_user.dart';
import 'package:events_app/shared/domain/repositories/session_repository.dart';

class GetCurrentSession {
  final SessionRepository _repo;

  GetCurrentSession(this._repo);

  CurrentSession call() {
    return _repo.getSession();
  }
}
