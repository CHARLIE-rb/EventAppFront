import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterv1/features/events/presentation/providers/events_notifier.dart';
import 'package:flutterv1/features/events/presentation/pages/event_day_screen.dart';
import 'package:flutterv1/features/events/presentation/pages/event_detail_screen.dart';
import 'package:flutterv1/features/events/presentation/widgets/custom_calendar_header.dart';
import 'package:flutterv1/features/events/presentation/widgets/custom_events_calendar.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    // No es necesario llamar load: el Notifier lo hizo al crearse.
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<EventsNotifier>();

    // 1) Loader mientras se inicializa
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // 2) Extraigo el estado ya “resuelto”
    final events = vm.visibleEvents;
    final firstDay = vm.firstAllowedDay;
    final lastDay = vm.lastAllowedDay;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Cabecera de calendario
          CalendarHeader(
            focusedDay: _focusedDay,
            firstDay: firstDay,
            lastDay: lastDay,
            onLeft: () {
              vm.goToPreviousMonth(_focusedDay);
              setState(
                () =>
                    _focusedDay =
                        vm.visibleEvents.isNotEmpty
                            ? vm.visibleEvents.first.startDateTime
                            : firstDay,
              );
            },
            onRight: () {
              vm.goToNextMonth(_focusedDay);
              setState(
                () =>
                    _focusedDay =
                        vm.visibleEvents.isNotEmpty
                            ? vm.visibleEvents.first.startDateTime
                            : lastDay,
              );
            },
            onTapMonth: (d) => setState(() => _focusedDay = d),
          ),

          const SizedBox(height: 12),

          // Calendario con events
          CustomEventsCalendar(
            focusedDay: _focusedDay,
            firstDay: firstDay,
            lastDay: lastDay,
            events: events,
            onDaySelected: (day) {
              final dayEvents = vm.eventsForDay(day);
              if (dayEvents.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => EventDayScreen(date: day, events: dayEvents),
                  ),
                );
              }
            },
          ),

          const SizedBox(height: 24),

          // Lista de eventos del mes
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (ctx, i) {
                final e = events[i];
                final hours = e.endDateTime.difference(e.startDateTime).inHours;
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.event),
                    title: Text(e.title),
                    subtitle: Text(
                      '${e.startDateTime.day}/${e.startDateTime.month}/${e.startDateTime.year} '
                      '– €${(e.ratePerHour * hours).toStringAsFixed(2)}',
                    ),
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
          ),
        ],
      ),
    );
  }
}
