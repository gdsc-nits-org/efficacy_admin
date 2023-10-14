import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class EventController {
  static const String _collectionName = "events";
  const EventController._();

  /// Assumption: (ClubID, title, startDate, endDate) combination is unique for each event
  static Future<EventModel?> create(EventModel event) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    await collection.insert(event.toJson());
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(EventFields.clubID.name, event.clubID);
    selectorBuilder.eq(EventFields.title.name, event.title);
    selectorBuilder.eq(EventFields.startDate.name, event.startDate);
    selectorBuilder.eq(EventFields.endDate.name, event.endDate);

    Map<String, dynamic>? res = await collection.findOne(selectorBuilder);
    return res == null ? null : EventModel.fromJson(res);
  }

  static Future<List<EventModel>> get({
    String? eventID,
    String? clubID,
  }) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    SelectorBuilder selectorBuilder = SelectorBuilder();
    if (eventID != null) {
      selectorBuilder.eq(EventFields.id.name, eventID);
    } else if (clubID != null) {
      selectorBuilder.eq(EventFields.clubID.name, clubID);
    } else {
      throw ArgumentError("EventID or clubID is required");
    }

    List<Map<String, dynamic>> res =
        await collection.find(selectorBuilder).toList();
    return res.map((model) => EventModel.fromJson(model)).toList();
  }

  static Future<EventModel> update(EventModel event) async {
    DbCollection collection = Database.instance.collection(_collectionName);
    if ((await get(eventID: event.id?.toHexString())).isEmpty) {
      throw Exception("Event not found");
    }
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(EventFields.id.name, event.id);
    await collection.updateOne(selectorBuilder, event);
    return event;
  }

  static Future<void> delete(String eventID) async {
    DbCollection collection = Database.instance.collection(_collectionName);
    if ((await get(eventID: eventID)).isEmpty) {
      throw Exception("Event not found");
    }
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(EventFields.id.name, eventID);
    await collection.deleteOne(selectorBuilder);
  }
}
