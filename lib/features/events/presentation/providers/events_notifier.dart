import 'package:flutter/material.dart';
import 'package:events_app/features/events/domain/usecases/get_event_by_id.dart';
import 'package:events_app/features/events/domain/usecases/get_events_by_ids.dart';
import 'package:events_app/features/events/domain/usecases/get_total_pay_for_event.dart';
import 'package:table_calendar/table_calendar.dart'; // Para isSameDay
import 'package:events_app/features/events/domain/entities/event.dart';
import 'package:events_app/features/events/domain/usecases/get_all_events.dart';
import 'package:events_app/features/events/domain/usecases/get_first_ever_event.dart';
import 'package:events_app/features/events/domain/usecases/get_last_event.dart';

enum TimeFilter { all, future, past }

class EventsNotifier extends ChangeNotifier {
  final GetAllEvents _getAll;
  final GetFirstEverEvent _getFirst;
  final GetLastEvent _getLast;
  final GetEventById _getEventById;
  final GetTotalPayForEvent _getTotalPayForEvent;
  final GetEventsByIds _getEventsByIds;

  bool isLoading = false;

  late DateTime firstAllowedDay;
  late DateTime lastAllowedDay;

  TimeFilter _timeFilter = TimeFilter.future;
  String? _selectedBrand;

  Future<Event> getEventById(String id) async => _getEventById(id);
  Future<List<Event>> getEventsByIds(List<String> ids) async =>
      _getEventsByIds(ids);
  Future<List<Event>> get allEvents async => _getAll();
  TimeFilter get timeFilter => _timeFilter;
  String? get selectedBrand => _selectedBrand;
  Future<double> getTotalPayForEvent(String eventid) =>
      _getTotalPayForEvent(eventid);

  Future<List<String>> get availableBrands =>
      _getAll().then((value) => value.map((e) => e.brand).toSet().toList());

  void setTimeFilter(TimeFilter filter) {
    _timeFilter = filter;
    notifyListeners();
  }

  void setSelectedBrand(String? brand) {
    _selectedBrand = brand;
    notifyListeners();
  }

  EventsNotifier(
    this._getAll,
    this._getFirst,
    this._getLast,
    this._getEventById,
    this._getTotalPayForEvent,
    this._getEventsByIds,
  );

  Future<void> initialize() async {
    isLoadingChanged(true);

    firstAllowedDay = await _getFirst();
    lastAllowedDay = await _getLast();

    isLoadingChanged(false);
  }

  void isLoadingChanged(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<List<Event>> get filteredEvents async {
    final now = DateTime.now();
    Iterable<Event> temp;

    switch (_timeFilter) {
      case TimeFilter.future:
        temp = await _getAll().then(
          (value) => value.where((e) => e.endDateTime.isAfter(now)),
        );
        break;
      case TimeFilter.past:
        temp = await _getAll().then(
          (value) => value.where((e) => e.endDateTime.isBefore(now)),
        );
        break;
      case TimeFilter.all:
        temp = await _getAll();
        break;
    }

    if (_selectedBrand != null && _selectedBrand!.isNotEmpty) {
      temp = temp.where((e) => e.brand == _selectedBrand);
    }

    return temp.toList();
  }

  Future<List<Event>> eventsForDay(DateTime day) async {
    return await _getAll().then(
      (value) => value.where((e) => isSameDay(e.startDateTime, day)).toList(),
    );
  }
}
