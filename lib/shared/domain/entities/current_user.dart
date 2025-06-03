import 'package:flutterv1/shared/domain/entities/auth_status.dart';

class CurrentUser {
  String? userId;
  UserStatus status;

  CurrentUser({required this.userId, required this.status});

  factory CurrentUser.uninitialized() =>
      CurrentUser(userId: null, status: UserStatus.uninitialized);
}
