import 'package:events_app/features/invitations/domain/entities/invitation.dart';

abstract class InvitationRepository {
  Future<Invitation> sendInvitation(String userId, String eventId);
  Future<Invitation> acceptInvitation(String invitationId);
  Future<Invitation> declineInvitation(String invitationId);
  Future<List<Invitation>> getPendingInvitations();
  Future<Invitation> cancelInvitation(String invitationId);
}
