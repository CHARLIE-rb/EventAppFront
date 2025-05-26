enum InvitationStatus { pending, accepted, declined, expired }

class Invitation {
  final String id;
  final String eventId;
  final String userId;
  final InvitationStatus status;
  final DateTime createdAt;

  Invitation({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.status,
    required this.createdAt,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      id: json['id'],
      eventId: json['event_id'],
      userId: json['user_id'],
      status: InvitationStatus.values.firstWhere(
        (e) => e.toString() == 'InvitationStatus.${json['status']}',
        orElse: () => InvitationStatus.pending,
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
