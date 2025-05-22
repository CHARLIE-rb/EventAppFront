import 'package:flutter/material.dart';

class NavItem implements Comparable<NavItem> {
  final int priority;
  final IconData icon;
  final String label;
  final Widget screen;

  NavItem({
    required this.priority,
    required this.icon,
    required this.label,
    required this.screen,
  });

  /// Comparación “por defecto”: ascendente según priority
  @override
  int compareTo(NavItem other) => priority.compareTo(other.priority);

  /// Comparador estático: ascendente por priority
  static int compareByPriorityAsc(NavItem a, NavItem b) =>
      a.priority.compareTo(b.priority);

  /// Comparador estático: descendente por priority
  static int compareByPriorityDesc(NavItem a, NavItem b) =>
      b.priority.compareTo(a.priority);

  /// Comparador: alfabético ascendente por label
  static int compareByLabelAsc(NavItem a, NavItem b) =>
      a.label.compareTo(b.label);

  /// Comparador: alfabético descendente por label
  static int compareByLabelDesc(NavItem a, NavItem b) =>
      b.label.compareTo(a.label);
}
