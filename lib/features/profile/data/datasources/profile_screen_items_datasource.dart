import 'package:events_app/features/profile/data/datasources/profile_screen_items_lists.dart';
import 'package:events_app/features/profile/data/models/profile_screen_item.dart';
import 'package:events_app/shared/domain/entities/user.dart';

class ProfileScreenItemsDatasource {
  ProfileScreenItems userScreenItems;
  ProfileScreenItemsDatasource(this.userScreenItems);
  List<ProfileScreenItem> getUserScreenItems(Role role) {
    switch (role) {
      case Role.ceo:
        return userScreenItems.ceoUserScreenItems..sort();
      case Role.manager:
        return userScreenItems.managerUserScreenItems..sort();
      case Role.company:
        return userScreenItems.companyUserScreenItems..sort();
      case Role.employee:
        return userScreenItems.employeeUserScreenItems..sort();
    }
  }
}
