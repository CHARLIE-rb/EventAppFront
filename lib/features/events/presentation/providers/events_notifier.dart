import 'package:flutter/material.dart';
import 'package:flutterv1/features/events/domain/entities/event.dart';
import 'package:flutterv1/features/events/domain/usecases/get_all_events.dart';
import 'package:flutterv1/features/events/domain/usecases/get_event_by_id.dart';
import 'package:flutterv1/features/events/domain/usecases/get_events_by_ids.dart';
import 'package:flutterv1/features/events/domain/usecases/get_first_ever_event.dart';
import 'package:flutterv1/features/events/domain/usecases/get_last_event.dart';
import 'package:flutterv1/features/events/domain/usecases/get_total_pay_for_event.dart';

class EventsNotifier extends ChangeNotifier {
  final GetAllEvents _getAll;
  final GetEventById _getById;
  final GetEventsByIds _getByIds;
  final GetFirstEverEvent _getFirstEverEvent;
  final GetLastEvent _getLastEvent;
  final GetTotalPayForEvent _getTotalPayForEvent;
  bool isLoading = false;

  EventsNotifier(
    this._getAll,
    this._getById,
    this._getByIds,
    this._getFirstEverEvent,
    this._getLastEvent,
    this._getTotalPayForEvent,
  );

  Future<List<Event>> getAllEvents() async {
    isLoading = true;
    notifyListeners();
    final result = await _getAll();
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Event> getEventById(String id) async {
    isLoading = true;
    notifyListeners();
    final result = await _getById(id);
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<List<Event>> getEventsByIds(List<String> ids) async {
    isLoading = true;
    notifyListeners();
    final result = await _getByIds(ids);
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<DateTime> getFirstEverEvent() async {
    isLoading = true;
    notifyListeners();
    final result = await _getFirstEverEvent();
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<DateTime> getLastEvent() async {
    isLoading = true;
    notifyListeners();
    final result = await _getLastEvent();
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<double> getTotalPayForEvent(String id) async {
    isLoading = true;
    notifyListeners();
    final result = await _getTotalPayForEvent(id);
    isLoading = false;
    notifyListeners();
    return result;
  }
}
