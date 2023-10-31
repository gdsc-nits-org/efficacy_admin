part of '../event_controller.dart';

Future<void> _deleteImpl(
    {required String eventID, required String clubID}) async {
  DbCollection collection =
      Database.instance.collection(EventController._collectionName);

  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq("_id", ObjectId.parse(eventID));

  if ((await collection.findOne(selectorBuilder)) == null) {
    throw Exception("Event not found");
  }
  await collection.deleteOne(selectorBuilder);
  await EventController._deleteLocal(eventID);
}
