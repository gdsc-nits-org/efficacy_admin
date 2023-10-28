part of '../invitation_controller.dart';

Future<void> _deleteLocalImpl(String id) async {
  Map? invitations = await LocalDatabase.get(
    LocalCollections.invitations,
    LocalDocuments.invitations,
  );
  if (invitations == null || !invitations.containsKey(id)) return;
  invitations.remove(id);
  await LocalDatabase.set(
    LocalCollections.invitations,
    LocalDocuments.invitations,
    invitations,
  );
}
