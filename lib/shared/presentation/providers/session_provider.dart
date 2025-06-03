import 'package:flutter/material.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/shared/domain/entities/auth_status.dart';
import 'package:flutterv1/shared/domain/usecases/change_userstatus.dart';
import 'package:flutterv1/shared/domain/usecases/get_current_user.dart';
import 'package:flutterv1/shared/domain/usecases/get_current_userstatus.dart';
import 'package:flutterv1/shared/domain/usecases/logout.dart';

class SessionProvider extends ChangeNotifier {
  final GetCurrentUser _getUser;
  final Logout _logout;
  final ChangeUserstatus _changeUserStatus;
  final GetCurrentUserstatus _getCurrentUserStatus;

  SessionProvider(
    this._getUser,
    this._logout,
    this._changeUserStatus,
    this._getCurrentUserStatus,
  ) {
    _load();
  }

  Future<void> _load() async {
    _changeUserStatus(UserStatus.uninitialized);
    final user = await _getUser();
    if (user != null) {
      _changeUserStatus(UserStatus.pinRequired);
    } else {
      _changeUserStatus(UserStatus.unauthenticated);
    }
    notifyListeners();
  }

  Future<User?> get currentUser async {
    return _getUser();
  }

  Future<UserStatus> get authStatus async => _getCurrentUserStatus();

  Future<void> logout() async {
    await _logout();
    _changeUserStatus(UserStatus.unauthenticated);
    notifyListeners();
  }
}
