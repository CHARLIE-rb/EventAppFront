import 'package:flutterv1/shared/domain/entities/auth_status.dart';
import 'package:flutterv1/shared/domain/repositories/session_repository.dart';

class ChangeSessionstatus {
  final SessionRepository _repo;
  ChangeSessionstatus(this._repo);
  void call(UserStatus userStatus) => _repo.changeSessionStatus(userStatus);
}
