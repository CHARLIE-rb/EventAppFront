import 'package:flutter/material.dart';
import 'package:flutterv1/features/events/data/models/event.dart';
import 'package:flutterv1/features/events/domain/usecases/get_all_events.dart';

class EventsNotifier extends ChangeNotifier {
  final GetAllEvents _getAll;
  List<Event> events = [];
  bool isLoading = false;

  EventsNotifier(this._getAll);

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    events = await _getAll();
    isLoading = false;
    notifyListeners();
  }
}
