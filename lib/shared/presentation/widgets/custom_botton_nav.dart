import 'package:flutter/material.dart';
import 'package:events_app/features/navigation/domain/entities/nav_item.dart';

/// Barra inferior que dibuja tantos iconos como items le pases.
class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final List<NavItem> items;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items:
          items.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
            );
          }).toList(),
      onTap: (index) {
        if (index != currentIndex) {
          // Reemplaza la ruta actual
          // Navigator.pushReplacementNamed(context, items[index].routeName);
        }
      },
    );
  }
}
