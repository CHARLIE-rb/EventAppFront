import 'package:flutterv1/shared/domain/repositories/session_repository.dart';

class ClearSession {
  final SessionRepository _repo;
  ClearSession(this._repo);
  Future<void> call() async => _repo.clearSession();
}
