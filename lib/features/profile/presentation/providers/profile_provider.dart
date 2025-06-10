import 'package:events_app/features/profile/data/models/profile_screen_item.dart';
import 'package:events_app/features/profile/domain/usecases/get_profile_screen_items.dart';
import 'package:events_app/shared/domain/entities/user.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final GetProfileScreenItems _getProfileScreenItems;
  ProfileProvider(this._getProfileScreenItems);

  List<ProfileScreenItem> getProfileScreenItems(Role role) {
    return _getProfileScreenItems(role);
  }
}
