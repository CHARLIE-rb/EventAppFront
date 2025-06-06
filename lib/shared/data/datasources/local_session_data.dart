import 'package:events_app/shared/domain/entities/current_user.dart';

class LocalSessionData {
  CurrentSession _currentSession = CurrentSession.uninitialized();
  CurrentSession get session => _currentSession;
  set session(CurrentSession session) {
    _currentSession = session;
  }
}
