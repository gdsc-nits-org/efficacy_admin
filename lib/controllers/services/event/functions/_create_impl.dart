part of '../event_controller.dart';

Future<EventModel?> _createImpl(EventModel event) async {
  event = event.copyWith(
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  DbCollection collection =
      Database.instance.collection(EventController._collectionName);

  await collection.insertOne(event.toJson());
  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq(EventFields.clubID.name, event.clubID);
  selectorBuilder.eq(EventFields.title.name, event.title);
  selectorBuilder.eq(
      EventFields.createdAt.name, event.createdAt!.toIso8601String());

  Map<String, dynamic>? res = await collection.findOne(selectorBuilder);

  if (res == null) return null;
  event = EventModel.fromJson(res);
  event = await EventController._save(event);
  return event;
}
