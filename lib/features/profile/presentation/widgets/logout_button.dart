import 'package:events_app/shared/presentation/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sessionProv = context.read<SessionProvider>();
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
        final navigator = Navigator.of(context);

        await showDialog<bool>(
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
                  onPressed: () => navigator.pop(false),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    navigator.pop(true);
                    sessionProv.logout();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                  ),
                  child: const Text('Sí'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
