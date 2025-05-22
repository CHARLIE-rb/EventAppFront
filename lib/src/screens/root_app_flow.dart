// lib/src/screens/root_app_flow.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterv1/src/models/role.dart';
import 'package:flutterv1/src/providers/auth_provider.dart';
import '../Utilities/nav_items.dart';
import '../models/forWidgets/nav_item.dart';

class RootAppFlow extends StatelessWidget {
  const RootAppFlow({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final role = context.watch<AuthProvider>().user?.role ?? Role.employee;
    final navItems = _navItemsForRole(role)..sort();

    return DefaultTabController(
      length: navItems.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SafeArea(
            child: Container(
              height: kToolbarHeight,
              alignment: Alignment.topLeft,
              // decoration: BoxDecoration(color: theme.colorScheme.surface),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // fila con TabBar a la izquierda y avatar a la derecha
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // el TabBar ocupa todo el espacio restante
                  Expanded(
                    child: TabBar(
                      isScrollable: true,
                      // quitas el indicador por defecto y evitas la aserción:
                      indicator: const BoxDecoration(),

                      labelColor: theme.colorScheme.primary,
                      unselectedLabelColor: theme.colorScheme.secondary,
                      labelStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                      // labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                      labelPadding: const EdgeInsets.only(right: 50),
                      physics: const BouncingScrollPhysics(),
                      tabs:
                          navItems.map((n) {
                            if (n.label == 'Perfil') {
                              return Tab(
                                child: CircleAvatar(
                                  backgroundColor: theme.colorScheme.secondary,
                                  child: Text(
                                    context
                                            .read<AuthProvider>()
                                            .user
                                            ?.name
                                            .substring(0, 1)
                                            .toUpperCase() ??
                                        'U',
                                    style: TextStyle(
                                      color: theme.colorScheme.surface,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Tab(text: n.label);
                            }
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(children: navItems.map((n) => n.screen).toList()),
      ),
    );
  }

  List<NavItem> _navItemsForRole(Role role) {
    switch (role) {
      case Role.ceo:
        return ceoNavItems;
      case Role.manager:
        return managerNavItems;
      case Role.company:
        return companyNavItems;
      case Role.employee:
        return employeeNavItems;
    }
  }
}
