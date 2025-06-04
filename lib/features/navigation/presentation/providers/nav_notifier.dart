// lib/features/navigation/presentation/providers/nav_notifier.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/features/navigation/domain/entities/nav_item.dart';
import 'package:flutterv1/features/navigation/domain/usecases/get_nav_items.dart';
import 'package:flutterv1/shared/domain/entities/user.dart';
import 'package:flutterv1/shared/presentation/providers/session_provider.dart';

class NavNotifier extends ChangeNotifier {
  final GetNavItems _getNavItems;
  final SessionProvider _sessionProvider;

  List<NavItem> items = [];

  NavNotifier(this._getNavItems, this._sessionProvider) {
    _load();
  }

  void _load() async {
    final user = await _sessionProvider.currentUser;
    items = _getNavItems(user?.role ?? Role.employee);
    notifyListeners();
  }
}
