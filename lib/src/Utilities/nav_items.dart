// lib/src/config/nav_items.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/src/screens/logged/profile_screen.dart';
import '../models/forWidgets/nav_item.dart';
import '../screens/logged/home_screen.dart';
import '../screens/logged/settings_screen.dart';

final List<NavItem> commonNavItems = [
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
