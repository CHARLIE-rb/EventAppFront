import 'package:flutter/material.dart';

class FaButtonAlignedToAppBar extends FloatingActionButtonLocation {
  final double yOffset; // desplazamiento desde el SafeArea top
  const FaButtonAlignedToAppBar({this.yOffset = 0});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry g) {
    // X: 16 px desde el borde start (respeta RTL/LTR)
    final double dx = g.minInsets.left + 16.0;

    // Y: padding superior (barra de estado) + desplazamiento deseado
    final double dy = g.minInsets.top + yOffset;

    return Offset(dx, dy);
  }
}
