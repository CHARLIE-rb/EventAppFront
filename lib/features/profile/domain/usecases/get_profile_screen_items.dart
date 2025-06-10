import 'package:events_app/features/profile/data/models/profile_screen_item.dart';
import 'package:events_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:events_app/shared/domain/entities/user.dart';

class GetProfileScreenItems {
  final ProfileRepository profileRepository;
  GetProfileScreenItems(this.profileRepository);
  List<ProfileScreenItem> call(Role role) {
    return profileRepository.getProfileScreenItems(role);
  }
}
