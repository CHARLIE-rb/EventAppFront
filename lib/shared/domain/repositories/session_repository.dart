import 'package:flutterv1/shared/domain/entities/auth_status.dart';
import 'package:flutterv1/shared/domain/entities/current_user.dart';

abstract class SessionRepository {
  Future<CurrentUser> getSession();
  Future<void> clearSession();
  Future<void> saveUserId(String userId);
  Future<void> changeUserStatus(UserStatus status);
  Future<UserStatus> getUserStatus();
  Future<String> getCurrentUserId();
}
