import 'package:events_app/shared/data/datasources/credential_storage.dart';
import 'package:events_app/shared/data/datasources/local_session_data.dart';
import 'package:events_app/shared/domain/entities/auth_status.dart';
import 'package:events_app/shared/domain/entities/current_user.dart';
import 'package:events_app/shared/domain/repositories/session_repository.dart';

class SessionRepositoryImpl extends SessionRepository {
  final LocalSessionData _localSessionData;
  final CredentialStorage _credentialStorage;
  SessionRepositoryImpl(this._localSessionData, this._credentialStorage);

  @override
  Future<Map<String, String>?> getLastSessionCredentials() async {
    return _credentialStorage.loadCredentials();
  }

  @override
  Future<void> clearSession() async {
    _localSessionData.session = CurrentSession.uninitialized();
    await _credentialStorage.clearCredentials();
  }

  @override
  CurrentSession getSession() {
    return _localSessionData.session;
  }

  @override
  Future<void> saveUser(String username, String password) async {
    setCurrentUsername(username);
    await _credentialStorage.saveCredentials(username, password);
  }

  @override
  Future<void> changeSessionStatus(UserStatus status) async {
    final session = _localSessionData.session;
    session.status = status;
    _localSessionData.session = session;
  }

  @override
  String? getCurrentUsername() {
    return _localSessionData.session.mail;
  }

  @override
  UserStatus getSessionStatus() {
    return _localSessionData.session.status;
  }

  @override
  void setCurrentUsername(String username) {
    final session = _localSessionData.session;
    session.mail = username;
    _localSessionData.session = session;
  }
}
