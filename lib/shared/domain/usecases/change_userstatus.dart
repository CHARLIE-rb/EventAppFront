import 'package:flutterv1/shared/domain/entities/auth_status.dart';
import 'package:flutterv1/shared/domain/repositories/session_repository.dart';

class ChangeUserstatus {
  final SessionRepository _repo;
  ChangeUserstatus(this._repo);
  void call(UserStatus userStatus) => _repo.changeUserStatus(userStatus);
}
