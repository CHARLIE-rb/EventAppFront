import 'package:events_app/features/events/data/datasources/event_data_source.dart';
import 'package:events_app/features/events/data/mappers/event_mapper.dart';
import 'package:events_app/features/events/domain/entities/event.dart';
import 'package:events_app/features/events/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventDataSource _eventDataSource;
  final EventMapper _eventMapper;

  EventRepositoryImpl(this._eventDataSource, this._eventMapper);

  @override
  Future<List<Event>> get allEvents => _eventDataSource.allEvents.then(
    (events) => events.map((event) => _eventMapper.toEvent(event)).toList(),
  );

  @override
  Future<List<Event>> getEventsByIds(List<String> ids) => _eventDataSource
      .eventsByIds(ids)
      .then(
        (events) => events.map((event) => _eventMapper.toEvent(event)).toList(),
      );

  @override
  Future<DateTime> get firstEverEvent => _eventDataSource.firstEverEvent;

  @override
  Future<Event> getEventById(String id) => _eventDataSource
      .getEventById(id)
      .then((event) => _eventMapper.toEvent(event));

  @override
  Future<DateTime> get lastEvent => _eventDataSource.lastEvent;
}
