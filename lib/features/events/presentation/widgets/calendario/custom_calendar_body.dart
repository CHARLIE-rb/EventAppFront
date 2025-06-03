// lib/widgets/events_calendar.dart
import 'package:flutter/material.dart';
import 'package:flutterv1/features/events/domain/entities/event.dart';
import 'package:table_calendar/table_calendar.dart';

/// Un TableCalendar configurado para mostrar tus [events].
/// El callback [onDaySelected] devuelve el día pulsado.
class CustomCalendarBody extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime firstDay;
  final DateTime lastDay;
  final List<Event> events;
  final void Function(DateTime) onDaySelected;

  const CustomCalendarBody({
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
      eventLoader:
          (day) =>
              events.where((e) => isSameDay(e.startDateTime, day)).toList(),
      onDaySelected: (selectedDay, focused) {
        onDaySelected(selectedDay);
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withAlpha((0.4 * 255).round()),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4),
        ),
        todayTextStyle: TextStyle(
          color: theme.colorScheme.surface,
          fontWeight: FontWeight.bold,
        ),
        selectedDecoration: BoxDecoration(
          color: theme.colorScheme.primary,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4),
        ),
        selectedTextStyle: TextStyle(
          color: theme.colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
        defaultDecoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(6),
        ),
        defaultTextStyle: TextStyle(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w400,
        ),
        weekendDecoration: BoxDecoration(
          color: theme.colorScheme.secondary.withAlpha(30),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(6),
        ),
        weekendTextStyle: TextStyle(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w400,
        ),
        outsideDecoration: BoxDecoration(
          color: Colors.transparent,
          // shape: BoxShape.rectangle,
          // borderRadius: BorderRadius.circular(6),
        ),
        outsideTextStyle: TextStyle(
          color: theme.colorScheme.onSurfaceVariant.withAlpha(50),
        ),
        rangeStartDecoration: BoxDecoration(
          color: theme.colorScheme.primary.withAlpha(80),
          shape: BoxShape.circle,
        ),
        rangeEndDecoration: BoxDecoration(
          color: theme.colorScheme.primary.withAlpha(80),
          shape: BoxShape.circle,
        ),
        rangeHighlightColor: theme.colorScheme.primary.withAlpha(20),
        // rangeMiddleDecoration: BoxDecoration(
        //   color: theme.colorScheme.primary.withOpacity(0.2),
        //   shape: BoxShape.rectangle,
        //   borderRadius: BorderRadius.circular(4),
        // ),
        markerDecoration: BoxDecoration(
          color: theme.colorScheme.surface,
          shape: BoxShape.circle,
        ),
        disabledDecoration: BoxDecoration(
          color: Colors.transparent,
          // color: Colors.grey.withAlpha(10),
          // shape: BoxShape.rectangle,
          // borderRadius: BorderRadius.circular(6),
        ),
        disabledTextStyle: TextStyle(
          color: theme.colorScheme.onSurface.withAlpha(50),
        ),
        // tableBorder: TableBorder(
        //   horizontalInside: BorderSide(
        //     color: theme.colorScheme.outline.withAlpha(50),
        //     width: 0.5,
        //   ),
        //   verticalInside: BorderSide(
        //     color: theme.colorScheme.outline.withAlpha(50),
        //     width: 0.5,
        //   ),
        // ),
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
          // Si NO hay eventos, devolvemos SizedBox vacío y no dibujamos nada.
          if (evts.isEmpty) return const SizedBox();

          // Si la fecha es la misma que 'focusedDay' (día seleccionado)...
          final bool isSelected = isSameDay(date, focusedDay);

          if (isSelected) {
            // 1) DÍA SELECCIONADO y además TIENE EVENTOS
            // Dibujamos un “anillo” o un puntito más grande para notarlo.
            // Por ejemplo, un anillo blanco-luminoso alrededor del círculo azul:

            return Positioned(
              bottom: 4,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Color blanco semitransparente como “halo”
                  color: Colors.white.withAlpha(200),
                ),
                child: Center(
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primary, // puntito principal
                    ),
                  ),
                ),
              ),
            );
          } else {
            // 2) DÍA NO SELECCIONADO pero TIENE EVENTOS
            // Dibujamos un puntito normal, más pequeño:
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
        },

        // Opcionalmente: personalizar cómo se pinta la celda “seleccionada”
        // usando selectedBuilder en vez de defaultBuilder. Esto no es
        // obligatorio, pero a veces sirve para centrar mejor el día:
        selectedBuilder: (ctx, date, _) {
          // Aquí podemos hacer, por ejemplo, un recuadro más grande,
          // para darle más contraste cuando esté seleccionado.
          return Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${date.day}',
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),

      headerVisible: false,
      // El predicado para saber “qué día está seleccionado”
      selectedDayPredicate: (day) => isSameDay(day, focusedDay),
    );
  }
}
