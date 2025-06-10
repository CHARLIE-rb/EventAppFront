import 'package:flutter/material.dart';
import 'package:events_app/features/events/domain/entities/event.dart';
import 'package:events_app/features/events/presentation/providers/events_notifier.dart';
import 'package:events_app/features/events/presentation/widgets/calendario/custom_calendar_body.dart';
import 'package:events_app/features/events/presentation/widgets/calendario/custom_calendar_header.dart';
import 'package:events_app/features/events/presentation/widgets/day_events_modal.dart';
import 'package:provider/provider.dart';

class CustomCalendarTogether extends StatefulWidget {
  const CustomCalendarTogether({super.key});

  @override
  State<CustomCalendarTogether> createState() => _CustomCalendarTogetherState();
}

class _CustomCalendarTogetherState extends State<CustomCalendarTogether> {
  late DateTime _focusedDay;
  late DateTime _today;

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
    _focusedDay = _today;
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos la instancia del notifier sin "escuchar" (solo para leer la configuración básica):
    final eN = context.read<EventsNotifier>();

    // Definimos los límites del calendario:
    final firstDay = eN.firstAllowedDay;
    final lastDay =
        eN.lastAllowedDay.isBefore(_today) ? _today : eN.lastAllowedDay;

    return Column(
      children: [
        // 1) HEADER del calendario (botones para cambiar mes / seleccionar mes)
        CalendarHeader(
          focusedDay: _focusedDay,
          firstDay: firstDay,
          lastDay: lastDay,
          onLeft: () {
            final prev = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
            setState(() {
              _focusedDay = prev.isBefore(firstDay) ? firstDay : prev;
            });
          },
          onRight: () {
            final next = DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
            setState(() {
              _focusedDay =
                  next.isAfter(lastDay)
                      ? lastDay
                      : (next.month == lastDay.month ? lastDay : next);
            });
          },
          onTapMonth: (d) => setState(() => _focusedDay = d),
        ),

        const SizedBox(height: 12),

        // 2) FUTUREBUILDER para cargar "todos los eventos" UNA sola vez (o hasta que quieras forzar un reload)
        FutureBuilder<List<Event>>(
          // Asumimos que EventsNotifier tiene un método/future llamado `events` que devuelve Future<List<Event>>
          future: eN.allEvents,
          builder: (context, snapshot) {
            // 2.1) Estado “cargando”
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height:
                    300, // tamaño aproximado para que no "salte" la UI cuando termine de cargar
                child: Center(child: CircularProgressIndicator()),
              );
            }
            // 2.2) Estado “error”
            if (snapshot.hasError) {
              return SizedBox(
                height: 300,
                child: Center(
                  child: Text(
                    'Error al cargar eventos: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            }

            final allEvents = snapshot.data!;

            return CustomCalendarBody(
              focusedDay: _focusedDay,
              firstDay: firstDay.isAfter(_focusedDay) ? _focusedDay : firstDay,
              lastDay: lastDay.isBefore(_focusedDay) ? _focusedDay : lastDay,
              events: allEvents, // pasan **todos** los eventos al Body
              onDaySelected: (day) async {
                // Capturamos el context antes del await para no cruzar el async gap
                final modalContext = context;
                // Suponemos que eventsForDay(day) devuelve Future<List<Event>> para ese día:
                final dayEvents = await eN.eventsForDay(day);
                if (!mounted) return;
                if (dayEvents.isNotEmpty) {
                  showModalBottomSheet(
                    context: modalContext,
                    isScrollControlled: true,
                    barrierColor: Colors.black54,
                    backgroundColor: Colors.transparent,
                    builder:
                        (_) => DayEventsModal(date: day, events: dayEvents),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
