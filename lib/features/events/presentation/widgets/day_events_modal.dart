// day_events_modal.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/features/events/domain/entities/event.dart';
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

    final width = mediQuery.size.width * 0.6;
    final height = mediQuery.size.height * 0.5;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Eventos de ${DateFormat('dd/MM/yyyy').format(date)}',
                style: theme.textTheme.titleMedium,
              ),
            ),
            const Divider(height: 1),
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
                      title: Text(e.title),
                      subtitle: Text(
                        '${e.startDateTime.hour.toString().padLeft(2, '0')}:'
                        '${e.startDateTime.minute.toString().padLeft(2, '0')} '
                        '– ${e.endDateTime.hour.toString().padLeft(2, '0')}:'
                        '${e.endDateTime.minute.toString().padLeft(2, '0')} '
                        ' (€${(e.ratePerHour * duration).toStringAsFixed(2)})',
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
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => navigator.pop(),
                child: const Text('Cerrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
