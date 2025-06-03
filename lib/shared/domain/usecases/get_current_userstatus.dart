import 'package:flutterv1/shared/domain/entities/auth_status.dart';
import 'package:flutterv1/shared/domain/repositories/session_repository.dart';

class GetCurrentUserstatus {
  final SessionRepository _repo;

  GetCurrentUserstatus(this._repo);

  Future<UserStatus> call() async {
    return _repo.getUserStatus();
  }
}
