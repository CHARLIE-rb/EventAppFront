// lib/features/navigation/domain/usecases/get_nav_items.dart
import 'package:events_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:events_app/features/navigation/domain/entities/nav_item.dart';
import 'package:events_app/shared/domain/entities/user.dart' show Role;
import 'package:events_app/features/events/presentation/pages/events_screen.dart';
import 'package:events_app/features/profile/presentation/pages/profile_screen.dart';
// import 'package:events_app/features/settings/presentation/pages/settings_screen.dart';

class GetNavItems {
  static final List<NavItem> commonNavItems = [
    NavItem(
      icon: Icons.home,
      label: 'Eventos',
      screen: EventsScreen(),
      priority: 1,
    ),
    NavItem(
      icon: Icons.person,
      label: 'Perfil',
      screen: ProfileScreen(),
      priority: 11,
    ),
  ];

  final List<NavItem> employeeNavItems = [...commonNavItems];

  final List<NavItem> ceoNavItems = [
    ...commonNavItems,
    NavItem(
      icon: Icons.chat,
      label: 'Consulta IA',
      screen: FakeChatScreen(),
      priority: 10,
    ),
  ];

  final List<NavItem> managerNavItems = [
    ...commonNavItems,
    NavItem(
      icon: Icons.chat,
      label: 'IA',
      screen: FakeChatScreen(),
      priority: 10,
    ),
  ];

  final List<NavItem> companyNavItems = [
    ...commonNavItems,
    NavItem(
      icon: Icons.chat,
      label: 'IA',
      screen: FakeChatScreen(),
      priority: 10,
    ),
  ];

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
