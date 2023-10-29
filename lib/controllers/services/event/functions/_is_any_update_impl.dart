part of '../event_controller.dart';

Future<bool> _isAnyUpdateImpl(String clubID, DateTime? lastChecked) async {
  DbCollection collection =
      Database.instance.collection(EventController._collectionName);

  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq(EventFields.clubID.name, clubID);
  if (lastChecked != null) {
    selectorBuilder.gt(
      EventFields.updatedAt.name,
      lastChecked.toIso8601String(),
    );
  }
  selectorBuilder.fields(["_id"]);

  dynamic res = await collection.findOne(selectorBuilder);
  return res != null;
}
