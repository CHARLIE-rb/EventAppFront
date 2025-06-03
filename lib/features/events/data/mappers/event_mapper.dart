import 'package:flutterv1/features/events/data/models/event_model.dart';
import 'package:flutterv1/features/events/domain/entities/event.dart';
import 'package:smartstruct/smartstruct.dart';

part 'event_mapper.mapper.g.dart';

@Mapper()
abstract class EventMapper {
  Event toEvent(EventModel model);
  EventModel toEventModel(Event user);

  FeedBack toFeedBack(FeedBackModel model);
  FeedBackModel toFeedbackModel(FeedBack user);
}
