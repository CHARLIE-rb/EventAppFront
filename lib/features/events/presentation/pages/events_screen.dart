import 'package:flutter/material.dart';
import 'package:flutterv1/features/events/presentation/widgets/day_events_modal.dart';
import 'package:provider/provider.dart';
import 'package:flutterv1/features/events/presentation/providers/events_notifier.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final eN = context.watch<EventsNotifier>();

    if (eN.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final events = eN.visibleEvents;
    final firstDay = eN.firstAllowedDay;
    final lastDay = eN.lastAllowedDay;
    final availableBrands = eN.availableBrands;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
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
                _focusedDay = next.isAfter(lastDay) ? lastDay : next;
              });
            },
            onTapMonth: (d) => setState(() => _focusedDay = d),
          ),

          const SizedBox(height: 12),

          CustomEventsCalendar(
            focusedDay: _focusedDay,
            firstDay: firstDay,
            lastDay: lastDay.isBefore(_focusedDay) ? _focusedDay : lastDay,
            events: events,
            onDaySelected: (day) async {
              // Capturamos el context antes del await para no cruzar el async gap
              final modalContext = context;
              final dayEvents = await eN.eventsForDay(day);
              // Verificamos que el State siga montado
              if (!mounted) return;
              if (dayEvents.isNotEmpty) {
                showModalBottomSheet(
                  context: modalContext,
                  isScrollControlled: true,
                  barrierColor: Colors.black54,
                  backgroundColor: Colors.transparent,
                  builder: (_) => DayEventsModal(date: day, events: dayEvents),
                );
              }
            },
          ),

          const SizedBox(height: 24),
          // 2) NUEVO: filtros
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 2.1) Filtro de tiempo
                Wrap(
                  spacing: 8,
                  children:
                      TimeFilter.values.map((tf) {
                        final label =
                            {
                              TimeFilter.future: 'Futuros',
                              TimeFilter.all: 'Todos',
                              TimeFilter.past: 'Pasados',
                            }[tf];
                        final isSelected = eN.timeFilter == tf;
                        return ChoiceChip(
                          label: Text(label!),
                          selected: isSelected,
                          onSelected: (_) => eN.setTimeFilter(tf),
                        );
                      }).toList(),
                ),

                SizedBox(height: 12),

                // 2.2) Filtro de marca
                // FutureBuilder<List<String>>(
                //   future: availableBrands,
                //   builder: (context, snapshot) {
                //     final brands = snapshot.data ?? [];
                //     return DropdownButton<String>(
                //       isExpanded: true,
                //       value: eN.selectedBrand,
                //       hint: Text('Filtrar por marca'),
                //       items: [
                //         const DropdownMenuItem(
                //           value: null,
                //           child: Text('Todas'),
                //         ),
                //         ...brands.map(
                //           (marca) => DropdownMenuItem(
                //             value: marca,
                //             child: Text(marca),
                //           ),
                //         ),
                //       ],
                //       onChanged: (marca) => eN.setSelectedBrand(marca),
                //     );
                //   },
                // ),
              ],
            ),
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
