import 'package:flutterv1/shared/domain/entities/auth_status.dart';
import 'package:flutterv1/shared/domain/entities/current_user.dart';

abstract class SessionRepository {
  CurrentSession getSession();
  UserStatus getSessionStatus();
  String? getCurrentUsername();
  void setCurrentUsername(String username);
  void changeSessionStatus(UserStatus status);
  Future<void> clearSession();
  Future<void> saveUser(String username, String password);
  Future<Map<String, String>?> getLastSessionCredentials();
}
