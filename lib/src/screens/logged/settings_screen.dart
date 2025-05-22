import 'package:flutter/material.dart';
import 'package:flutterv1/src/Utilities/routes.dart';
import 'package:flutterv1/src/providers/auth_provider.dart';
import 'package:flutterv1/src/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget logoutButton() {
      return TextButton.icon(
        icon: Icon(Icons.logout_rounded, color: theme.colorScheme.error),
        label: Text(
          'Log out',
          style: TextStyle(color: theme.colorScheme.error, fontSize: 18),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          iconSize: 20,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.center,
        ).copyWith(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
        ),
        onPressed: () async {
          final authProvider = context.read<AuthProvider>();
          final navigator = Navigator.of(context);

          final shouldLogout = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (dialogCtx) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Text('Confirmación', style: theme.textTheme.titleLarge),
                content: Text(
                  '¿Seguro que quieres salir?',
                  style: theme.textTheme.bodyMedium,
                ),
                actionsPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(dialogCtx).pop(false),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(dialogCtx).pop(true),
                    style: TextButton.styleFrom(
                      foregroundColor: theme.colorScheme.error,
                    ),
                    child: const Text('Sí'),
                  ),
                ],
              );
            },
          );

          if (shouldLogout == true) {
            authProvider.logout();
            if (context.mounted) {
              navigator.pushReplacementNamed(AppRoutes.login);
            }
          }
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              SwitchListTile(
                title: Text('Notificaciones'),
                value: true,
                onChanged: (_) {},
              ),
              SwitchListTile(
                title: Text('Modo Oscuro'),
                value: theme.brightness == Brightness.dark,
                onChanged: (_) => context.read<ThemeProvider>().toggle(),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Acerca de'),
                onTap:
                    () => showAboutDialog(
                      context: context,
                      applicationName: 'Mi Flutter App',
                      applicationVersion: '1.0.0',
                    ),
              ),
              const SizedBox(height: 24),
            ]),
          ),

          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: logoutButton(),
            ),
          ),
        ],
      ),
    );
  }
}
