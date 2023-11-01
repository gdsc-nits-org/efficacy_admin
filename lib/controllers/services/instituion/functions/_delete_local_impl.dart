part of '../institution_controller.dart';

Future<void> _deleteLocalImpl(String id) async {
  List<String> data = LocalDatabase.get(LocalDocuments.institutions.name);
  Map institutions = data.isEmpty ? {} : jsonDecode(data[0]);

  if (!institutions.containsKey(id)) return;
  institutions.remove(id);
  await LocalDatabase.set(
    LocalDocuments.events.name,
    [jsonEncode(institutions)],
  );
}
