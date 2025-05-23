// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

class EventMapperImpl extends EventMapper {
  EventMapperImpl() : super();

  @override
  Event toEvent(EventModel model) {
    final event = Event(
      id: model.id,
      title: model.title,
      brand: model.brand,
      startDateTime: model.startDateTime,
      endDateTime: model.endDateTime,
      locationName: model.locationName,
      latitude: model.latitude,
      longitude: model.longitude,
      mapUrl: model.mapUrl,
      functionDescription: model.functionDescription,
      clothesDescription: model.clothesDescription,
      clothesImageUrl: model.clothesImageUrl,
      instructions: model.instructions,
      ratePerHour: model.ratePerHour,
      employeesIds: model.employeesIds.map((e) => e).toList(),
      managerInChargeId: model.managerInChargeId,
      companyFeedback: model.companyFeedback == null
          ? null
          : toFeedBack(model.companyFeedback!),
      employeeFeedbacks:
          model.employeeFeedbacks.map((x) => toFeedBack(x)).toList(),
    );
    return event;
  }

  @override
  EventModel toEventModel(Event user) {
    final eventmodel = EventModel(
      id: user.id,
      title: user.title,
      brand: user.brand,
      startDateTime: user.startDateTime,
      endDateTime: user.endDateTime,
      locationName: user.locationName,
      latitude: user.latitude,
      longitude: user.longitude,
      mapUrl: user.mapUrl,
      functionDescription: user.functionDescription,
      clothesDescription: user.clothesDescription,
      clothesImageUrl: user.clothesImageUrl,
      instructions: user.instructions,
      ratePerHour: user.ratePerHour,
      employeesIds: user.employeesIds.map((e) => e).toList(),
      managerInChargeId: user.managerInChargeId,
      companyFeedback: user.companyFeedback == null
          ? null
          : toFeedbackModel(user.companyFeedback!),
      employeeFeedbacks:
          user.employeeFeedbacks.map((x) => toFeedbackModel(x)).toList(),
    );
    return eventmodel;
  }

  @override
  FeedBack toFeedBack(FeedBackModel model) {
    final feedback = FeedBack(
      id: model.id,
      rating: model.rating,
      comment: model.comment,
      timestamp: model.timestamp,
    );
    return feedback;
  }

  @override
  FeedBackModel toFeedbackModel(FeedBack user) {
    final feedbackmodel = FeedBackModel(
      id: user.id,
      rating: user.rating,
      comment: user.comment,
      timestamp: user.timestamp,
    );
    return feedbackmodel;
  }
}
