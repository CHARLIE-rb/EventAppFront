import 'package:flutter/material.dart';
import 'package:flutterv1/shared/domain/entities/current_user.dart';
import 'package:flutterv1/shared/domain/entities/user.dart';
import 'package:flutterv1/shared/domain/entities/auth_status.dart';
import 'package:flutterv1/shared/domain/usecases/session/change_session_status.dart';
import 'package:flutterv1/shared/domain/usecases/session/clear_session.dart';
import 'package:flutterv1/shared/domain/usecases/session/get_current_session.dart';
import 'package:flutterv1/shared/domain/usecases/session/get_current_user.dart';
import 'package:flutterv1/shared/domain/usecases/session/get_current_session_status.dart';
import 'package:flutterv1/shared/domain/usecases/session/logout.dart';

class SessionProvider extends ChangeNotifier {
  final GetCurrentUser _getCurrentUser;
  final Logout _logout;
  final ChangeSessionstatus _changeUserStatus;
  final GetCurrentSessionstatus _getCurrentUserStatus;
  final GetCurrentSession _getCurrentSession;
  final ClearSession _clearSession;

  SessionProvider(
    this._getCurrentUser,
    this._logout,
    this._changeUserStatus,
    this._getCurrentUserStatus,
    this._clearSession,
    this._getCurrentSession,
  ) {
    _init();
  }

  CurrentSession get currentSession => _getCurrentSession();

  Future<void> _init() async {
    _changeUserStatus(UserStatus.uninitialized);
    final user = await _getCurrentUser();
    if (user != null) {
      _changeUserStatus(UserStatus.pinRequired);
    } else {
      _changeUserStatus(UserStatus.unauthenticated);
    }
    notifyListeners();
  }

  Future<User?> get currentUser async {
    return _getCurrentUser();
  }

  UserStatus get authStatus => _getCurrentUserStatus();

  Future<void> logout() async {
    await _logout();
    _clearSession();
    notifyListeners();
  }
}
