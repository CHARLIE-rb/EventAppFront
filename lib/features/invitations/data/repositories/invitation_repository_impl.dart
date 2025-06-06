import 'package:events_app/features/invitations/domain/entities/invitation.dart';
import 'package:events_app/features/invitations/domain/repositories/invitation_repository.dart';

class InvitationRepositoryImpl implements InvitationRepository {
  //TODO: poner el datasource de invitaciones + mappers en caso de que haga falta
  @override
  Future<Invitation> acceptInvitation(String invitationId) {
    // TODO: implement acceptInvitation
    throw UnimplementedError();
  }

  @override
  Future<Invitation> cancelInvitation(String invitationId) {
    // TODO: implement cancelInvitation
    throw UnimplementedError();
  }

  @override
  Future<Invitation> declineInvitation(String invitationId) {
    // TODO: implement declineInvitation
    throw UnimplementedError();
  }

  @override
  Future<List<Invitation>> getPendingInvitations() {
    // TODO: implement getPendingInvitations
    throw UnimplementedError();
  }

  @override
  Future<Invitation> sendInvitation(String userId, String eventId) {
    // TODO: implement sendInvitation
    throw UnimplementedError();
  }
}
