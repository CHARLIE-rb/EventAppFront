import 'package:flutter/material.dart';
import 'package:events_app/shared/domain/entities/current_user.dart';
import 'package:events_app/shared/domain/entities/user.dart';
import 'package:events_app/shared/domain/entities/auth_status.dart';
import 'package:events_app/shared/domain/usecases/session/change_session_status.dart';
import 'package:events_app/shared/domain/usecases/session/clear_session.dart';
import 'package:events_app/shared/domain/usecases/session/get_current_session.dart';
import 'package:events_app/shared/domain/usecases/session/get_current_user.dart';
import 'package:events_app/shared/domain/usecases/session/get_current_session_status.dart';
import 'package:events_app/shared/domain/usecases/users/load_last_user.dart';

class SessionProvider extends ChangeNotifier {
  final GetCurrentUser _getCurrentUser;
  final ChangeSessionstatus _changeUserStatus;
  final GetCurrentSessionstatus _getCurrentUserStatus;
  final GetCurrentSession _getCurrentSession;
  final ClearSession _clearSession;
  final LoadLastUser _loadLastUser;

  SessionProvider(
    this._getCurrentUser,
    this._changeUserStatus,
    this._getCurrentUserStatus,
    this._clearSession,
    this._getCurrentSession,
    this._loadLastUser,
  );

  CurrentSession get currentSession => _getCurrentSession();

  Future<void> initialize() async {
    await _loadLastUser();
    final user = await _getCurrentUser();
    if (user != null) {
      _changeUserStatus(UserStatus.pinRequired);
    } else {
      _changeUserStatus(UserStatus.unauthenticated);
    }
  }

  void reload() => notifyListeners();

  Future<User?> get currentUser async {
    return _getCurrentUser();
  }

  UserStatus get authStatus => _getCurrentUserStatus();

  Future<void> logout() async {
    await _clearSession();
    _changeUserStatus(UserStatus.unauthenticated);
    reload();
  }
}
