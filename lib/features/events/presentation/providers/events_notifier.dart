import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // Para isSameDay
import 'package:flutterv1/features/events/domain/entities/event.dart';
import 'package:flutterv1/features/events/domain/usecases/get_all_events.dart';
import 'package:flutterv1/features/events/domain/usecases/get_first_ever_event.dart';
import 'package:flutterv1/features/events/domain/usecases/get_last_event.dart';

enum TimeFilter { all, future, past }

class EventsNotifier extends ChangeNotifier {
  final GetAllEvents _getAll;
  final GetFirstEverEvent _getFirst;
  final GetLastEvent _getLast;

  EventsNotifier(this._getAll, this._getFirst, this._getLast) {
    _init();
  }

  bool isLoading = false;

  List<Event> visibleEvents = [];
  DateTime firstAllowedDay = DateTime.now();
  DateTime lastAllowedDay = DateTime.now();

  TimeFilter _timeFilter = TimeFilter.future;
  String? _selectedBrand;

  TimeFilter get timeFilter => _timeFilter;
  String get selectedBrand => _selectedBrand ?? '';

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

  Future<void> _init() async {
    isLoading = true;
    notifyListeners();

    firstAllowedDay = await _getFirst();
    lastAllowedDay = await _getLast();
    visibleEvents = await _getAll();

    isLoading = false;
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
