import 'package:flutter/material.dart';

class ProfileScreenItem implements Comparable<ProfileScreenItem> {
  final int priority;
  final IconData icon;
  final String label;
  final WidgetBuilder screen;

  ProfileScreenItem({
    required this.priority,
    required this.icon,
    required this.label,
    required this.screen,
  });

  /// Comparación “por defecto”: ascendente según priority
  @override
  int compareTo(ProfileScreenItem other) => priority.compareTo(other.priority);

  /// Comparador estático: ascendente por priority
  static int compareByPriorityAsc(ProfileScreenItem a, ProfileScreenItem b) =>
      a.priority.compareTo(b.priority);

  /// Comparador estático: descendente por priority
  static int compareByPriorityDesc(ProfileScreenItem a, ProfileScreenItem b) =>
      b.priority.compareTo(a.priority);

  /// Comparador: alfabético ascendente por label
  static int compareByLabelAsc(ProfileScreenItem a, ProfileScreenItem b) =>
      a.label.compareTo(b.label);

  /// Comparador: alfabético descendente por label
  static int compareByLabelDesc(ProfileScreenItem a, ProfileScreenItem b) =>
      b.label.compareTo(a.label);
}
