import 'package:flutter/material.dart';
import 'package:flutterv1/features/events/domain/entities/event.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({super.key, required this.event, required this.theme});

  final Event event;
  final ThemeData theme;

  Future<void> _openMap(double lat, double lng, String label) async {
    // geo: sólo para Android elige entre apps
    final geoUri = Uri.parse('geo:$lat,$lng?q=${Uri.encodeComponent(label)}');
    if (await canLaunchUrl(geoUri)) {
      await launchUrl(geoUri, mode: LaunchMode.externalApplication);
      return;
    }
    final web = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );
    await launchUrl(web, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final totalPay =
        (event.endDateTime.difference(event.startDateTime).inHours *
            event.ratePerHour);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          children: [
            // 1. Bloque de texto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd MMM yyyy').format(event.startDateTime),
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${DateFormat.Hm().format(event.startDateTime)} – '
                    '${DateFormat.Hm().format(event.endDateTime)}',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '€${totalPay.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // 2. Botón de ubicación
            ElevatedButton(
              onPressed:
                  () => _openMap(
                    event.latitude,
                    event.longitude,
                    event.locationName,
                  ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: const EdgeInsets.all(12),
                backgroundColor: theme.colorScheme.primaryContainer,
                elevation: 4,
                shadowColor: theme.colorScheme.primary.withAlpha(
                  (0.2 * 255).toInt(),
                ),
              ),
              child: Icon(
                Icons.location_on,
                color: theme.colorScheme.onPrimaryContainer,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
