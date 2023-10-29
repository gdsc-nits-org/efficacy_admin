part of '../event_controller.dart';

Future<EventModel> _saveImpl(EventModel event) async {
  Map? events = await LocalDatabase.get(
    LocalCollections.event,
    LocalDocuments.events,
  );
  events ??= {};
  event = event.copyWith(lastLocalUpdate: DateTime.now());
  events[event.id] = event.toJson();
  await LocalDatabase.set(
    LocalCollections.event,
    LocalDocuments.events,
    events,
  );
  return event;
}
