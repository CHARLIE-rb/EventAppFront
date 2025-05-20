// lib/src/config/nav_items.dart
import 'package:flutter/material.dart';
import '../models/forWidgets/nav_item.dart';
import '../screens/logged/home_screen.dart';
import '../screens/logged/settings_screen.dart';

final List<NavItem> commonNavItems = [
  NavItem(icon: Icons.home, label: 'Inicio', screen: HomeScreen(), priority: 1),
  NavItem(
    icon: Icons.settings,
    label: 'Ajustes',
    screen: SettingsScreen(),
    priority: 10,
  ),
];

final List<NavItem> employeeNavItems = [...commonNavItems];

final List<NavItem> ceoNavItems = [...commonNavItems];

final List<NavItem> managerNavItems = [...commonNavItems];

final List<NavItem> companyNavItems = [...commonNavItems];
