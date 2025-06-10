// day_events_modal.dart
import 'package:flutter/material.dart';
import 'package:events_app/features/events/domain/entities/event.dart';
import 'package:intl/intl.dart';
import '../pages/event_detail_screen.dart';

class DayEventsModal extends StatelessWidget {
  final DateTime date;
  final List<Event> events;

  const DayEventsModal({super.key, required this.date, required this.events});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);
    final mediQuery = MediaQuery.of(context);

    final width = mediQuery.size.width * 0.8;
    final height = mediQuery.size.height * 0.5;

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'Eventos del ${DateFormat('dd/MM/yyyy').format(date)}',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
      content: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            const Divider(),
            Expanded(
              child: Scrollbar(
                child: ListView.separated(
                  itemCount: events.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (ctx, i) {
                    final e = events[i];
                    final duration =
                        e.endDateTime.difference(e.startDateTime).inHours;
                    return ListTile(
                      leading: const Icon(Icons.event),
                      title: Text(e.title, style: theme.textTheme.titleLarge),
                      subtitle: Text(
                        '${e.startDateTime.hour.toString().padLeft(2, '0')}:'
                        '${e.startDateTime.minute.toString().padLeft(2, '0')} '
                        '– ${e.endDateTime.hour.toString().padLeft(2, '0')}:'
                        '${e.endDateTime.minute.toString().padLeft(2, '0')} '
                        ' (€${(e.ratePerHour * duration).toStringAsFixed(2)})',
                        style: theme.textTheme.bodyMedium,
                      ),
                      onTap: () {
                        // navigator.pop(); // Cierra el diálogo
                        navigator.push(
                          MaterialPageRoute(
                            builder: (_) => EventDetailScreen(event: e),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: TextButton(
            //     onPressed: () => navigator.pop(),
            //     child: const Text('Cerrar'),
            //   ),
            // ),
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
