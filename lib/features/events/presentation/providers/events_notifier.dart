import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // Para isSameDay
import 'package:flutterv1/features/events/domain/entities/event.dart';
import 'package:flutterv1/features/events/domain/usecases/get_all_events.dart';
import 'package:flutterv1/features/events/domain/usecases/get_first_ever_event.dart';
import 'package:flutterv1/features/events/domain/usecases/get_last_event.dart';

/// Notifier que centraliza TODO el estado y la lógica
/// de cargar eventos, calcular límites y filtrar por mes/día.
class EventsNotifier extends ChangeNotifier {
  final GetAllEvents _getAll;
  final GetFirstEverEvent _getFirst;
  final GetLastEvent _getLast;

  // Estado interno
  List<Event> _allEvents = [];
  bool isLoading = false;

  // Estado expuesto a la UI
  List<Event> visibleEvents = [];
  DateTime firstAllowedDay = DateTime.now();
  DateTime lastAllowedDay = DateTime.now();

  EventsNotifier(this._getAll, this._getFirst, this._getLast) {
    _init();
  }

  Future<void> _init() async {
    isLoading = true;
    notifyListeners();

    // 1) Cargo todos los eventos
    _allEvents = await _getAll();

    // 2) Calculo las fechas extremas
    firstAllowedDay = await _getFirst();
    lastAllowedDay = await _getLast();

    // 3) Inicializo la vista al mes actual
    _updateVisible(DateTime.now());

    isLoading = false;
    notifyListeners();
  }

  /// Actualiza [visibleEvents] según el mes de [focused],
  /// y notifica a la UI.
  void _updateVisible(DateTime focused) {
    visibleEvents =
        _allEvents.where((e) {
          return e.startDateTime.year == focused.year &&
              e.startDateTime.month == focused.month;
        }).toList();
    notifyListeners();
  }

  /// Mueve un mes atrás y actualiza la vista.
  void goToPreviousMonth(DateTime currentFocused) {
    final prev = DateTime(currentFocused.year, currentFocused.month - 1, 1);
    final newFocused = prev.isBefore(firstAllowedDay) ? firstAllowedDay : prev;
    _updateVisible(newFocused);
  }

  /// Mueve un mes adelante y actualiza la vista.
  void goToNextMonth(DateTime currentFocused) {
    final next = DateTime(currentFocused.year, currentFocused.month + 1, 1);
    final newFocused = next.isAfter(lastAllowedDay) ? lastAllowedDay : next;
    _updateVisible(newFocused);
  }

  /// Devuelve la lista de eventos para un día concreto.
  List<Event> eventsForDay(DateTime day) {
    return _allEvents.where((e) => isSameDay(e.startDateTime, day)).toList();
  }
}
