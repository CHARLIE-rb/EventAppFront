import 'package:events_app/features/profile/data/datasources/profile_screen_items_datasource.dart';
import 'package:events_app/features/profile/data/models/profile_screen_item.dart';
import 'package:events_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:events_app/shared/domain/entities/user.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileScreenItemsDatasource userScreenItems;
  ProfileRepositoryImpl(this.userScreenItems);
  @override
  List<ProfileScreenItem> getProfileScreenItems(Role role) {
    return userScreenItems.getUserScreenItems(role);
  }
}
