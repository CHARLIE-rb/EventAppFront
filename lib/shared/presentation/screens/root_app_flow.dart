// lib/src/screens/root_app_flow.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/shared/domain/entities/user.dart';
import 'package:flutterv1/features/navigation/presentation/providers/nav_notifier.dart';
import 'package:flutterv1/shared/presentation/providers/session_provider.dart';
import 'package:provider/provider.dart';

class RootAppFlow extends StatelessWidget {
  const RootAppFlow({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nav = context.watch<NavNotifier>();
    final userProvider = context.read<SessionProvider>();
    final navItems = nav.items;

    if (navItems.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return DefaultTabController(
      length: navItems.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SafeArea(
            child: Container(
              height: kToolbarHeight,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TabBar(
                      isScrollable: true,
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
                      labelPadding: const EdgeInsets.only(right: 50),
                      physics: const BouncingScrollPhysics(),
                      tabs:
                          navItems.map((n) {
                            if (n.label == 'Perfil') {
                              return FutureBuilder<User?>(
                                future: userProvider.currentUser,
                                builder: (context, snapshot) {
                                  // Mientras el future no termine, mostramos una U por defecto
                                  String letra = 'U';
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasData &&
                                        snapshot.data!.name.isNotEmpty) {
                                      letra =
                                          snapshot.data!.name
                                              .substring(0, 1)
                                              .toUpperCase();
                                    }
                                  }

                                  return Tab(
                                    child: CircleAvatar(
                                      backgroundColor:
                                          theme.colorScheme.secondary,
                                      child: Text(
                                        letra,
                                        style: TextStyle(
                                          color: theme.colorScheme.surface,
                                        ),
                                      ),
                                    ),
                                  );
                                },
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
}
