// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/src/screens/logged/event_day_screen.dart';
import 'package:flutterv1/src/screens/logged/event_detail_screen.dart';
import 'package:flutterv1/src/services/event_service.dart';
import 'package:flutterv1/src/widgets/calendario/custom_calendar_header.dart';
import 'package:flutterv1/src/widgets/calendario/custom_events_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _svc = EventService();
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
  }

  void _goToPreviousMonth() {
    final firstDay = _svc.firstAllowedDay;
    final prev = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
    setState(() {
      _focusedDay = prev.isBefore(firstDay) ? firstDay : prev;
    });
  }

  void _goToNextMonth() {
    final lastDay = _svc.lastAllowedDay;
    final next = DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
    setState(() {
      _focusedDay = next.isAfter(lastDay) ? lastDay : next;
    });
  }

  void _pickMonth(DateTime picked) {
    setState(() {
      _focusedDay = picked;
    });
  }

  void _onDaySelected(DateTime day) {
    final dayEvents =
        _svc.visibleEvents
            .where((e) => isSameDay(e.startDateTime, day))
            .toList();
    if (dayEvents.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EventDayScreen(date: day, events: dayEvents),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final events = _svc.visibleEvents;
    final firstDay = _svc.firstAllowedDay;
    final lastDay = _svc.lastAllowedDay;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 1) Cabecera separada
          CalendarHeader(
            focusedDay: _focusedDay,
            firstDay: firstDay,
            lastDay: lastDay,
            onLeft: _goToPreviousMonth,
            onRight: _goToNextMonth,
            onTapMonth: _pickMonth,
          ),

          // 2) Calendario separado
          CustomEventsCalendar(
            focusedDay: _focusedDay,
            firstDay: firstDay,
            lastDay: lastDay,
            events: events,
            onDaySelected: _onDaySelected,
          ),

          const SizedBox(height: 24),

          // 3) Lista de eventos
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (ctx, i) {
                final e = events[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.event),
                    title: Text(e.title),
                    subtitle: Text(
                      '${e.startDateTime.day}/${e.startDateTime.month}/${e.startDateTime.year} '
                      '– €${(e.ratePerHour * e.endDateTime.difference(e.startDateTime).inHours).toStringAsFixed(2)}',
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
