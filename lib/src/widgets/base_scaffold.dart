import 'package:flutter/material.dart';
// import 'package:flutterv1/src/widgets/custom_botton_nav.dart';
// import '../config/nav_items.dart';

/// Scaffold genérico que añade AppBar + CustomBottomNav
class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final int currentIndex;

  const BaseScaffold({
    super.key,
    required this.title,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: child,
      // bottomNavigationBar: CustomBottomNav(
      //   currentIndex: currentIndex,
      //   items: navItems,
      // ),
    );
  }
}
