import 'package:flutterv1/shared/domain/entities/current_user.dart';
import 'package:flutterv1/shared/domain/repositories/session_repository.dart';

class GetCurrentSession {
  final SessionRepository _repo;

  GetCurrentSession(this._repo);

  CurrentSession call() {
    return _repo.getSession();
  }
}
