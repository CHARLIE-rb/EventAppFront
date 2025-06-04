import 'package:flutterv1/shared/domain/entities/auth_status.dart';

class CurrentSession {
  String? username;
  UserStatus status;

  CurrentSession({required this.username, required this.status});

  factory CurrentSession.uninitialized() =>
      CurrentSession(username: null, status: UserStatus.uninitialized);
}
