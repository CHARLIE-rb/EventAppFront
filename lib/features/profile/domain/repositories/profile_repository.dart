import 'package:events_app/features/profile/data/models/profile_screen_item.dart';
import 'package:events_app/shared/domain/entities/user.dart';

abstract class ProfileRepository {
  List<ProfileScreenItem> getProfileScreenItems(Role role);
}
