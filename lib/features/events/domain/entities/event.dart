class FeedBack {
  final String id;
  final int rating; // 1–5
  final String comment; // puede estar vacío
  final DateTime timestamp; // cuándo se dejó

  FeedBack({
    required this.id,
    required this.rating,
    this.comment = '',
    required this.timestamp,
  });
}

class Event {
  final String id;
  final String title;
  final String brand;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String locationName;
  final double latitude;
  final double longitude;
  final String mapUrl;
  final String functionDescription;
  final String clothesDescription;
  final String clothesImageUrl;
  final String instructions;
  final double ratePerHour;

  final List<String> employeesIds;
  final String managerInChargeId;

  final List<FeedBack> employeeFeedbacks;
  final FeedBack? companyFeedback;

  Event({
    required this.id,
    required this.title,
    required this.brand,
    required this.startDateTime,
    required this.endDateTime,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.mapUrl,
    required this.functionDescription,
    required this.clothesDescription,
    required this.clothesImageUrl,
    required this.instructions,
    required this.ratePerHour,

    required this.employeesIds,
    required this.managerInChargeId,

    this.companyFeedback,
    this.employeeFeedbacks = const [],
  });
}
