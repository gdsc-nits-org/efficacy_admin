part of '../invitation_controller.dart';

Future<InvitationModel> _saveImpl(InvitationModel invitation) async {
  List<String> data = LocalDatabase.get(LocalDocuments.invitations.name);

  Map invitations = data.isEmpty ? {} : jsonDecode(data[0]);
  invitation = invitation.copyWith(lastLocalUpdate: DateTime.now());
  invitations[invitation.id] = invitation.toJson();

  await LocalDatabase.set(
    LocalDocuments.invitations.name,
    [jsonEncode(invitations)],
  );
  return invitation;
}
