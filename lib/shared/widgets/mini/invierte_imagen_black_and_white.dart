import 'package:flutter/material.dart';

class InvierteImagenBnW extends StatelessWidget {
  const InvierteImagenBnW({
    super.key,
    required this.theme,
    required this.imagePath,
    required this.width,
  });

  final ThemeData theme;
  final String imagePath;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter:
          theme.brightness == Brightness.dark
              ? ColorFilter.mode(Colors.transparent, BlendMode.dst)
              : ColorFilter.mode(
                theme.colorScheme.surface,
                BlendMode.difference,
              ),
      child: Image.asset(imagePath, width: width),
    );
  }
}
