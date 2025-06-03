import 'package:flutterv1/shared/data/datasources/local_session_data.dart';
import 'package:flutterv1/shared/domain/entities/auth_status.dart';
import 'package:flutterv1/shared/domain/entities/current_user.dart';
import 'package:flutterv1/shared/domain/repositories/session_repository.dart';

class SessionRepositoryImpl extends SessionRepository {
  final LocalSessionData _localSessionData;
  SessionRepositoryImpl(this._localSessionData);
  @override
  Future<void> clearSession() async {
    _localSessionData.session = CurrentUser.uninitialized();
  }

  @override
  Future<CurrentUser> getSession() async {
    return _localSessionData.session;
  }

  @override
  Future<void> saveUserId(String userId) async {
    final session = _localSessionData.session;
    session.userId = userId;
    _localSessionData.session = session;
  }

  @override
  Future<void> changeUserStatus(UserStatus status) async {
    final session = _localSessionData.session;
    session.status = status;
    _localSessionData.session = session;
  }

  @override
  Future<String> getCurrentUserId() async {
    return _localSessionData.session.userId ?? '';
  }

  @override
  Future<UserStatus> getUserStatus() async {
    return _localSessionData.session.status;
  }
}
