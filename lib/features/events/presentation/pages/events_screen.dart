import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutterv1/features/events/domain/entities/event.dart';
import 'package:flutterv1/features/events/presentation/providers/events_notifier.dart';
import 'package:flutterv1/features/events/presentation/widgets/calendario/custom_calendar_together.dart';
import 'package:flutterv1/features/events/presentation/pages/event_detail_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  /// Guardamos aquí el Future que carga los eventos filtrados.
  /// De este modo, el FutureBuilder no vuelve a dispararse en cada build,
  /// sino solo cuando reasignemos esta variable.
  Future<List<Event>>? _filteredEventsFuture;

  @override
  void initState() {
    super.initState();
    // Al iniciar la pantalla, pedimos la lista filtrada con los valores por defecto:
    final eN = context.read<EventsNotifier>();
    _filteredEventsFuture = eN.filteredEvents;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Consumer<EventsNotifier>(
        builder: (context, eN, _) {
          // 1) Si aún está cargando los datos básicos (firstAllowedDay / lastAllowedDay), mostramos un loader:
          if (eN.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2) Una vez fuera de isLoading, construimos la UI entera:
          return Column(
            children: [
              // --- a) CALENDARIO: delegamos a CustomCalendarTogether ---
              //     Internamente, CustomCalendarTogether ya usa un FutureBuilder
              //     para cargar “todos los eventos” y no se recarga al cambiar filtros.
              const CustomCalendarTogether(),

              const Divider(height: 32, thickness: 1),

              // --- b) TÍTULO + FILTROS ---
              const Text(
                'Eventos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // b.1) Filtro de tiempo (ChoiceChips)
                    Wrap(
                      spacing: 8,
                      children:
                          TimeFilter.values.map((tf) {
                            // Etiqueta según el enum
                            final label =
                                {
                                  TimeFilter.future: 'Futuros',
                                  TimeFilter.all: 'Todos',
                                  TimeFilter.past: 'Pasados',
                                }[tf]!;

                            final isSelected = (eN.timeFilter == tf);

                            return ChoiceChip(
                              label: Text(label),
                              selected: isSelected,
                              onSelected: (_) {
                                // 1) Actualizo el filtro en el notifier
                                eN.setTimeFilter(tf);

                                // 2) Reasigno el Future para que el FutureBuilder se dispare de nuevo
                                setState(() {
                                  _filteredEventsFuture = eN.filteredEvents;
                                });
                              },
                            );
                          }).toList(),
                    ),

                    const SizedBox(height: 12),

                    // b.2) Filtro de marca (DropdownButton construyendo las opciones desde availableBrands)
                    FutureBuilder<List<String>>(
                      future: eN.availableBrands,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Todavía no tenemos la lista de marcas
                          return const SizedBox();
                        }
                        if (snapshot.hasError) {
                          // Hubo un error al cargar las marcas
                          return Text(
                            'Error cargando marcas: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          );
                        }
                        final brands = snapshot.data!;

                        return DropdownButton<String?>(
                          isExpanded: true,
                          value: eN.selectedBrand,
                          hint: const Text('Filtrar por marca'),
                          items: [
                            const DropdownMenuItem(
                              value: null,
                              child: Text('Todas'),
                            ),
                            ...brands.map(
                              (marca) => DropdownMenuItem(
                                value: marca,
                                child: Text(marca),
                              ),
                            ),
                          ],
                          onChanged: (marca) {
                            // 1) Actualizamos el filtro de marca en el notifier
                            eN.setSelectedBrand(marca);

                            // 2) Reasignamos el Future para que el FutureBuilder de la lista
                            //    vuelva a ejecutarse con el nuevo filtro
                            setState(() {
                              _filteredEventsFuture = eN.filteredEvents;
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // --- c) LISTA DE EVENTOS FILTRADOS (en FutureBuilder) ---
              Expanded(
                child: FutureBuilder<List<Event>>(
                  future: _filteredEventsFuture,
                  builder: (ctx, snapshot) {
                    // c.1) MIENTRAS el Future está cargando:
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    // c.2) SI hay error al obtener la lista:
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error al cargar eventos filtrados:\n${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    // c.3) YA tenemos datos:
                    final filteredEvents = snapshot.data!;

                    // c.4) Si la lista está vacía, mostramos un mensaje:
                    if (filteredEvents.isEmpty) {
                      return const Center(
                        child: Text('No hay eventos que coincidan'),
                      );
                    }

                    // c.5) Si hay eventos, construimos el ListView
                    return ListView.builder(
                      itemCount: filteredEvents.length,
                      itemBuilder: (ctx, i) {
                        final e = filteredEvents[i];
                        final hours =
                            e.endDateTime.difference(e.startDateTime).inHours;

                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.event),
                            title: Text(e.title),
                            subtitle: Text(
                              '${e.startDateTime.day}/${e.startDateTime.month}/${e.startDateTime.year}  – '
                              '€${(e.ratePerHour * hours).toStringAsFixed(2)}',
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
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
