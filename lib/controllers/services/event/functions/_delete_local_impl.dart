part of '../event_controller.dart';

Future<void> _deleteLocalImpl(String id) async {
  Map? events =
      await LocalDatabase.get(LocalCollections.event, LocalDocuments.events);
  if (events == null || !events.containsKey(id)) return;
  events.remove(id);
  await LocalDatabase.set(
    LocalCollections.event,
    LocalDocuments.events,
    events,
  );
}
