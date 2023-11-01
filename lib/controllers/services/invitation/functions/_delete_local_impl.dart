part of '../invitation_controller.dart';

Future<void> _deleteLocalImpl(String id) async {
  List<String> data = LocalDatabase.get(LocalDocuments.invitations.name);
  Map? invitations = data.isEmpty ? {} : jsonDecode(data[0]);
  if (invitations == null || !invitations.containsKey(id)) return;
  invitations.remove(id);
  await LocalDatabase.set(
    LocalDocuments.invitations.name,
    [jsonEncode(invitations)],
  );
}
