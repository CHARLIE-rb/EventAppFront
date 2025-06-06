import 'package:flutter/material.dart';
import 'package:events_app/features/theme/presentation/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);
    return AlertDialog(
      // Reducimos los márgenes laterales para disponer de más ancho:
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 24.0,
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      title: const Text('Ajustes'),
      content: SizedBox(
        // Ajustamos el ancho para que quepan las palabras completas
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('Modo Oscuro'),
              secondary: const Icon(Icons.brightness_6),
              value: theme.brightness == Brightness.dark,
              onChanged: (_) {
                context.read<ThemeProvider>().toggle();
              },
            ),
            SwitchListTile(
              title: const Text('Notificaciones'),
              secondary: const Icon(Icons.notifications),
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
                // Aquí deberías llamar a la lógica real para activar/desactivar notificaciones.
                // Por ejemplo:
                // Provider.of<NotificationsService>(context, listen: false)
                //     .setEnabled(value);
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Cambiar contraseña'),
              onTap: () {
                navigator.pop();
                // Navegar a pantalla de cambiar contraseña, por ejemplo
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Política de privacidad'),
              onTap: () {
                navigator.pop();
                // Mostrar política de privacidad
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => navigator.pop(),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
