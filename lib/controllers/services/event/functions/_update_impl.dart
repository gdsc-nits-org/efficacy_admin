part of '../event_controller.dart';

Future<EventModel> _updateImpl(EventModel event) async {
  event = event.copyWith(updatedAt: DateTime.now());

  DbCollection collection =
      Database.instance.collection(EventController._collectionName);
  SelectorBuilder selectorBuilder = SelectorBuilder();

  List<EventModel> oldData =
      await EventController.get(eventID: event.id, forceGet: true).first;
  if (oldData.isEmpty) {
    throw Exception("Event not found");
  }
  selectorBuilder.eq("_id", ObjectId.parse(event.id!));
  await collection.updateOne(
    selectorBuilder,
    compare(
      oldData.first.toJson(),
      event.toJson(),
    ).map,
  );
  event = await EventController._save(event);
  return event;
}
