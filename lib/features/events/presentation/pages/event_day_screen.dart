// lib/screens/event_day_screen.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/features/events/data/models/event_model.dart';
import 'package:flutterv1/features/events/presentation/pages/event_detail_screen.dart';

class EventDayScreen extends StatelessWidget {
  final DateTime date;
  final List<EventModel> events;

  const EventDayScreen({super.key, required this.date, required this.events});

  @override
  Widget build(BuildContext context) {
    final label = '${date.day}/${date.month}/${date.year}';
    return Scaffold(
      appBar: AppBar(title: Text('Eventos $label')),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (ctx, i) {
          final e = events[i];
          final start = e.startDateTime;
          final end = e.endDateTime;
          final timeLabel =
              '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}'
              ' – '
              '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
          return Card(
            child: ListTile(
              title: Text(e.title),
              subtitle: Text(timeLabel),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EventDetailScreen(event: e),
                    ),
                  ),
            ),
          );
        },
      ),
    );
  }
}
