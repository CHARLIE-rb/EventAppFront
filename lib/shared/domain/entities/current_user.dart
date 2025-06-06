import 'package:events_app/shared/domain/entities/auth_status.dart';

class CurrentSession {
  String? mail;
  UserStatus status;

  CurrentSession({required this.mail, required this.status});

  factory CurrentSession.uninitialized() =>
      CurrentSession(mail: null, status: UserStatus.uninitialized);
}
