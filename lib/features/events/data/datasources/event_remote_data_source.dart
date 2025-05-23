import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/features/events/data/models/event.dart';

abstract class EventRemoteDataSource {
  List<Event> get allEvents;
  User get currentUser;
  List<Event> get visibleEvents;
  DateTime get firstAllowedDay;
  DateTime get lastAllowedDay;
  double totalPayFor(Event e);
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  @override
  // TODO: implement allEvents
  List<Event> get allEvents => throw UnimplementedError();

  @override
  // TODO: implement currentUser
  User get currentUser => throw UnimplementedError();

  @override
  // TODO: implement firstAllowedDay
  DateTime get firstAllowedDay => throw UnimplementedError();

  @override
  // TODO: implement lastAllowedDay
  DateTime get lastAllowedDay => throw UnimplementedError();

  @override
  double totalPayFor(Event e) {
    // TODO: implement totalPayFor
    throw UnimplementedError();
  }

  @override
  // TODO: implement visibleEvents
  List<Event> get visibleEvents => throw UnimplementedError();
}
