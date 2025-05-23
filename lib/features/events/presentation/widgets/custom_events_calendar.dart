// lib/widgets/events_calendar.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/features/events/domain/entities/event.dart';
import 'package:table_calendar/table_calendar.dart';

/// Un TableCalendar configurado para mostrar tus [events].
/// El callback [onDaySelected] devuelve el día pulsado.
class CustomEventsCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final List<Event> events;
  final void Function(DateTime) onDaySelected;

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
      calendarFormat: CalendarFormat.month,
      startingDayOfWeek: StartingDayOfWeek.monday,
      eventLoader: (day) {
        // Devuelve los eventos cuyo startDateTime coincide con [day]
        return events.where((e) => isSameDay(e.startDateTime, day)).toList();
      },
      onDaySelected: (selectedDay, focused) {
        onDaySelected(selectedDay);
      },
      calendarStyle: CalendarStyle(
        defaultTextStyle: TextStyle(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w400,
        ),
        weekendTextStyle: TextStyle(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w400,
        ),
        markerDecoration: BoxDecoration(
          color: theme.colorScheme.primary,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withAlpha((0.4 * 255).round()),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4),
        ),
        todayTextStyle: TextStyle(
          color: theme.colorScheme.surface,
          fontWeight: FontWeight.bold,
        ),
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
                  color: theme.colorScheme.primary,
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
      headerVisible: false, // ocultamos la cabecera por separado
      selectedDayPredicate: (day) => isSameDay(day, focusedDay),
    );
  }
}
