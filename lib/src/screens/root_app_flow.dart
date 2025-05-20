// lib/src/screens/root_screen.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/src/models/role.dart';
import 'package:flutterv1/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../Utilities/nav_items.dart';
import '../models/forWidgets/nav_item.dart';

class RootAppFlow extends StatefulWidget {
  const RootAppFlow({super.key});

  @override
  State<RootAppFlow> createState() => _RootAppFlow();
}

class _RootAppFlow extends State<RootAppFlow> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<NavItem> navItems = _navItemsRole();
    navItems.sort();
    final NavItem current = navItems[_currentIndex];

    navItems.sort();
    return Scaffold(
      body: current.screen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items:
            navItems.map((item) {
              return BottomNavigationBarItem(
                icon: Icon(item.icon),
                label: item.label,
              );
            }).toList(),
        onTap: (int idx) {
          setState(() => _currentIndex = idx);
        },
      ),
    );
  }

  List<NavItem> _navItemsRole() {
    final currentRole =
        context.read<AuthProvider>().user?.role ?? Role.employee;

    return switch (currentRole) {
      Role.ceo => ceoNavItems,
      Role.employee => employeeNavItems,
      Role.manager => managerNavItems,
      Role.company => companyNavItems,
    };
  }
}
