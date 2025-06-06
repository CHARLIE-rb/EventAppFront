import 'package:flutter/material.dart';
import 'package:events_app/features/navigation/domain/entities/nav_item.dart';
import 'package:events_app/features/navigation/domain/usecases/get_nav_items.dart';
import 'package:events_app/shared/domain/usecases/session/get_current_user.dart';

class NavNotifier extends ChangeNotifier {
  final GetNavItems _getNavItems;
  final GetCurrentUser _getCurrentUser;

  List<NavItem> items = [];

  NavNotifier(this._getNavItems, this._getCurrentUser);

  Future<void> load() async {
    final user = await _getCurrentUser();
    items = _getNavItems(user!.role);
    notifyListeners();
  }
}
