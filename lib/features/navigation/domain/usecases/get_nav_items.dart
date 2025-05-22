// lib/features/navigation/domain/usecases/get_nav_items.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/features/navigation/domain/entities/nav_item.dart';
import 'package:flutterv1/features/auth/domain/entities/user.dart' show Role;
import 'package:flutterv1/features/events/presentation/pages/home_screen.dart';
import 'package:flutterv1/features/profile/presentations/pages/profile_screen.dart';
import 'package:flutterv1/features/settings/presentation/pages/settings_screen.dart';

class GetNavItems {
  static final List<NavItem> commonNavItems = [
    NavItem(
      icon: Icons.home,
      label: 'Eventos',
      screen: HomeScreen(),
      priority: 1,
    ),
    NavItem(
      icon: Icons.settings,
      label: 'Ajustes',
      screen: SettingsScreen(),
      priority: 10,
    ),
    NavItem(
      icon: Icons.person,
      label: 'Perfil',
      screen: ProfileScreen(),
      priority: 11,
    ),
  ];

  final List<NavItem> employeeNavItems = [...commonNavItems];

  final List<NavItem> ceoNavItems = [...commonNavItems];

  final List<NavItem> managerNavItems = [...commonNavItems];

  final List<NavItem> companyNavItems = [...commonNavItems];

  List<NavItem> call(Role role) {
    switch (role) {
      case Role.ceo:
        return ceoNavItems..sort();
      case Role.manager:
        return managerNavItems..sort();
      case Role.company:
        return companyNavItems..sort();
      case Role.employee:
        return employeeNavItems..sort();
    }
  }
}
