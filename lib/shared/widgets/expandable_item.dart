import 'package:flutter/material.dart';

/// Modelo genérico para cualquier panel desplegable
class ExpandableItem {
  final String title;
  final IconData icon;
  final Widget body;

  const ExpandableItem({
    required this.title,
    required this.icon,
    required this.body,
  });
}
