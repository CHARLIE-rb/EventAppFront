import 'package:events_app/features/profile/data/models/profile_screen_item.dart';
import 'package:events_app/features/settings/presentation/pages/settings_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreenItems {
  static final List<ProfileScreenItem> _commonUserScreenItems = [
    ProfileScreenItem(
      icon: Icons.person,
      label: 'Datos personales',
      screen: (context) => SettingsScreen(),
      priority: 1,
    ),

    ProfileScreenItem(
      icon: Icons.settings,
      label: 'Configuración',
      screen: (context) => SettingsScreen(),
      priority: 3,
    ),
  ];

  final List<ProfileScreenItem> employeeUserScreenItems = [
    ..._commonUserScreenItems,
    ProfileScreenItem(
      icon: Icons.access_time,
      label: 'Disponibilidad',
      screen: (context) => SettingsScreen(),
      priority: 2,
    ),
  ];

  final List<ProfileScreenItem> ceoUserScreenItems = [
    ..._commonUserScreenItems,
  ];

  final List<ProfileScreenItem> managerUserScreenItems = [
    ..._commonUserScreenItems,
  ];

  final List<ProfileScreenItem> companyUserScreenItems = [
    ..._commonUserScreenItems,
  ];
}
