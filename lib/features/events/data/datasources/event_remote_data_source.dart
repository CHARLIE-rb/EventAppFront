import 'package:flutterv1/features/events/data/datasources/event_data_source.dart';
import 'package:flutterv1/features/events/data/models/event_model.dart';

class EventRemoteDataSourceImpl implements EventDataSource {
  @override
  // TODO: implement allEvents
  Future<List<EventModel>> get allEvents => throw UnimplementedError();

  @override
  Future<List<EventModel>> eventsByIds(List<String> ids) {
    // TODO: implement eventsByIds
    throw UnimplementedError();
  }

  @override
  // TODO: implement firstEverEvent
  Future<DateTime> get firstEverEvent => throw UnimplementedError();

  @override
  Future<EventModel> getEventById(String id) {
    // TODO: implement getEventById
    throw UnimplementedError();
  }

  @override
  // TODO: implement lastEvent
  Future<DateTime> get lastEvent => throw UnimplementedError();
}
