// lib/features/navigation/presentation/providers/nav_notifier.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/features/navigation/domain/entities/nav_item.dart';
import 'package:flutterv1/features/navigation/domain/usecases/get_nav_items.dart';
import 'package:flutterv1/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart';

class NavNotifier extends ChangeNotifier {
  final GetNavItems _getNavItems;
  final AuthProvider _auth;

  List<NavItem> items = [];

  NavNotifier(this._getNavItems, this._auth) {
    _load();
  }

  void _load() {
    final role = _auth.user?.role ?? Role.employee;
    items = _getNavItems(role);
    // opcional: sort por priority
    // items.sort();
    notifyListeners();
  }
}
