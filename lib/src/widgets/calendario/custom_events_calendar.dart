// lib/widgets/events_calendar.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutterv1/src/models/event.dart';

class CustomEventsCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final List<Event> events;
  final ValueChanged<DateTime> onDaySelected;

  const CustomEventsCalendar({
    super.key,
    required this.focusedDay,
    required this.firstDay,
    required this.lastDay,
    required this.events,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TableCalendar<Event>(
      firstDay: firstDay,
      lastDay: lastDay,
      focusedDay: focusedDay,
      headerVisible: false,
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      selectedDayPredicate: (_) => false,
      calendarStyle: CalendarStyle(
        // estilo para días de la semana normales
        defaultTextStyle: TextStyle(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w400,
        ),
        // estilo para sábados y domingos
        weekendTextStyle: TextStyle(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w400,
        ),
        // si quisieras ocultar o atenuar los días fuera de mes:
        // outsideDaysVisible: false,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: theme.colorScheme.secondary,
          fontWeight: FontWeight.w400,
        ),
        weekendStyle: TextStyle(
          color: theme.colorScheme.secondary,
          fontWeight: FontWeight.w700,
        ),
      ),
      onDaySelected: (day, _) {
        onDaySelected(day);
      },
      eventLoader:
          (day) =>
              events.where((e) => isSameDay(e.startDateTime, day)).toList(),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (ctx, date, evts) {
          if (evts.isNotEmpty) {
            return Positioned(
              bottom: 4,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.secondary,
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
