part of '../event_controller.dart';

Future<void> _deleteImpl({required String eventID}) async {
  DbCollection collection =
      Database.instance.collection(EventController._collectionName);

  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq("_id", ObjectId.parse(eventID));

  Map<String, dynamic>? res = await collection.findOne(selectorBuilder);
  if (res == null) {
    throw Exception("Event not found");
  }
  EventModel event = EventModel.fromJson(
    Formatter.convertMapToMapStringDynamic(res)!,
  );
  if (event.posterPublicID.isNotEmpty) {
    await ImageController.delete(
      publicID: event.posterPublicID,
    );
  }
  await collection.deleteOne(selectorBuilder);
  await EventController._deleteLocal(eventID);
}
