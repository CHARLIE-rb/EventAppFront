enum InvitationStatusModel { pending, accepted, declined, expired }

class InvitationModel {
  final String id;
  final String eventId;
  final String userId;
  final InvitationStatusModel status;
  final DateTime createdAt;

  InvitationModel({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.status,
    required this.createdAt,
  });

  factory InvitationModel.fromJson(Map<String, dynamic> json) {
    return InvitationModel(
      id: json['id'],
      eventId: json['event_id'],
      userId: json['user_id'],
      status: InvitationStatusModel.values.firstWhere(
        (e) => e.toString() == 'InvitationStatus.${json['status']}',
        orElse: () => InvitationStatusModel.pending,
      ),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'user_id': userId,
      'status': status.toString().split('.').last,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
