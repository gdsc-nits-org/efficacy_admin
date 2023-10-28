import 'package:efficacy_admin/controllers/utils/comparator.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:efficacy_admin/utils/local_database/constants.dart';
import 'package:efficacy_admin/utils/local_database/local_database.dart';
import 'package:mongo_dart/mongo_dart.dart';

class EventController {
  static const String _collectionName = "events";
  const EventController._();

  static Future<EventModel> _save(EventModel event) async {
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

  static Future<void> _deleteLocal(String id) async {
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

  /// Assumption: (ClubID, title, startDate, endDate) combination is unique for each event
  static Future<EventModel?> create(EventModel event) async {
    event = event.copyWith(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    DbCollection collection = Database.instance.collection(_collectionName);

    await collection.insertOne(event.toJson());
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(EventFields.clubID.name, event.clubID);
    selectorBuilder.eq(EventFields.title.name, event.title);
    selectorBuilder.eq(
        EventFields.createdAt.name, event.createdAt!.toIso8601String());

    Map<String, dynamic>? res = await collection.findOne(selectorBuilder);

    if (res == null) return null;
    event = EventModel.fromJson(res);
    event = await _save(event);
    return event;
  }

  //
  static Future<bool> isAnyUpdate(String clubID, DateTime? lastChecked) async {
    DbCollection collection = Database.instance.collection(_collectionName);

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

  /// If [forceGet] is true, the localDatabase is cleared and new data is fetched
  /// Else only the users not in database are fetched
  static Stream<List<EventModel>> get({
    String? eventID,
    String? clubID,
    bool forceGet = false,
  }) async* {
    List<EventModel> filteredEvents = [];

    // Local Data
    Map localEvents = await LocalDatabase.get(
          LocalCollections.event,
          LocalDocuments.events,
        ) ??
        {};
    if (forceGet) {
      await LocalDatabase.deleteCollection(LocalCollections.event);
    } else {
      if (localEvents.isNotEmpty) {
        if (eventID != null && localEvents.containsKey(eventID)) {
          filteredEvents.add(EventModel.fromJson(
            Formatter.convertMapToMapStringDynamic(localEvents[eventID])!,
          ));
        } else if (clubID != null) {
          for (dynamic key in localEvents.keys) {
            localEvents[key] =
                Formatter.convertMapToMapStringDynamic(localEvents[key]);
            if (localEvents[key] != null &&
                localEvents[key][EventFields.clubID.name] == clubID) {
              filteredEvents.add(EventModel.fromJson(localEvents[key]));
            }
          }
        }
        if (filteredEvents.isNotEmpty) yield filteredEvents;
      }
    }
    // Server data
    DbCollection collection = Database.instance.collection(_collectionName);

    SelectorBuilder selectorBuilder = SelectorBuilder();
    if (eventID != null) {
      selectorBuilder.eq("_id", eventID);
    } else if (clubID != null) {
      selectorBuilder.eq(EventFields.clubID.name, clubID);
    } else {
      throw ArgumentError("EventID or clubID is required");
    }

    List<Map<String, dynamic>> res =
        await collection.find(selectorBuilder).toList();
    filteredEvents = res.map((model) => EventModel.fromJson(model)).toList();
    for (int i = 0; i < filteredEvents.length; i++) {
      filteredEvents[i] = await _save(filteredEvents[i]);
    }
    yield filteredEvents;
  }

  static Future<EventModel> update(EventModel event) async {
    event = event.copyWith(updatedAt: DateTime.now());

    DbCollection collection = Database.instance.collection(_collectionName);
    SelectorBuilder selectorBuilder = SelectorBuilder();

    selectorBuilder.eq("_id", event.id);
    List<EventModel> oldData =
        await get(eventID: event.id, forceGet: true).first;
    if (oldData.isNotEmpty) {
      throw Exception("Event not found");
    }
    await collection.updateOne(
      selectorBuilder,
      compare(
        oldData.first.toJson(),
        event.toJson(),
      ).map,
    );
    event = await _save(event);
    return event;
  }

  static Future<void> delete(String eventID) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq("_id", eventID);

    if ((await collection.findOne(selectorBuilder)) == null) {
      throw Exception("Event not found");
    }
    await collection.deleteOne(selectorBuilder);
    await _deleteLocal(eventID);
  }
}
