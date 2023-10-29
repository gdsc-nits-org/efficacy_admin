part of '../invitation_controller.dart';

Future<InvitationModel> _saveImpl(InvitationModel invitation) async {
  Map? invitations = await LocalDatabase.get(
    LocalCollections.invitations,
    LocalDocuments.invitations,
  );
  invitations ??= {};
  invitation = invitation.copyWith(lastLocalUpdate: DateTime.now());
  invitations[invitation.id] = invitation.toJson();
  await LocalDatabase.set(
    LocalCollections.invitations,
    LocalDocuments.invitations,
    invitations,
  );
  return invitation;
}
