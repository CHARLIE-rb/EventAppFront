import 'package:flutterv1/shared/domain/entities/current_user.dart';

class LocalSessionData {
  CurrentUser currentUser = CurrentUser.uninitialized();
  CurrentUser get session => currentUser;
  set session(CurrentUser user) {
    currentUser = user;
  }
}
