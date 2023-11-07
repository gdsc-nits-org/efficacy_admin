part of '../event_controller.dart';

Future<EventModel> _saveImpl(EventModel event) async {
  List<String> data = LocalDatabase.get(LocalDocuments.events.name);
  Map events = data.isEmpty ? {} : jsonDecode(data[0]);

  event = event.copyWith(lastLocalUpdate: DateTime.now());
  events[event.id] = event.toJson();
  await LocalDatabase.set(
    LocalDocuments.events.name,
    [jsonEncode(events)],
  );
  return event;
}
