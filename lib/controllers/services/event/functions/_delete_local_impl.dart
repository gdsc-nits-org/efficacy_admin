part of '../event_controller.dart';

Future<void> _deleteLocalImpl(String id) async {
  List<String> data = LocalDatabase.get(LocalDocuments.events.name);
  Map events = data.isEmpty ? {} : jsonDecode(data[0]);

  if (!events.containsKey(id)) return;
  events.remove(id);
  await LocalDatabase.set(
    LocalDocuments.events.name,
    [jsonEncode(events)],
  );
}
