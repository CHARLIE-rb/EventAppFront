import 'package:flutterv1/features/events/data/datasources/event_remote_data_source.dart';
import 'package:flutterv1/features/events/data/datasources/events_local_data_source.dart';
import 'package:flutterv1/features/events/data/models/event.dart';
import 'package:flutterv1/features/events/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource _remote;
  final EventLocalDataSource _local;

  EventRepositoryImpl(this._remote, this._local);

  @override
  Future<List<Event>> getAllEvents() async {
    try {
      final models = await _remote.fetchEvents();
      return models.map((m) => m.toEntity()).toList();
    } catch (_) {
      final models = await _local.fetchEvents();
      return models.map((m) => m.toEntity()).toList();
    }
  }

  @override
  Future<Event> getEventById(String id) async =>
      (await getAllEvents()).firstWhere((e) => e.id == id);
}
