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
    Map? events =
        await LocalDatabase.get(LocalCollections.event, LocalDocuments.events);
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

  static Future<void> _delete(String id) async {
    Map? events =
        await LocalDatabase.get(LocalCollections.event, LocalDocuments.events);
    if (events == null || !events.containsKey(id)) return;
    events.remove(id);
    await LocalDatabase.set(
        LocalCollections.event, LocalDocuments.events, events);
  }

  /// Assumption: (ClubID, title, startDate, endDate) combination is unique for each event
  static Future<EventModel?> create(EventModel event) async {
    DbCollection collection = Database.instance.collection(_collectionName);

    await collection.insert(event.toJson());
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(EventFields.clubID.name, event.clubID);
    selectorBuilder.eq(EventFields.title.name, event.title);

    List<Map<String, dynamic>> res =
        await collection.find(selectorBuilder).toList();

    Map<String, dynamic>? data;
    for (dynamic model in res) {
      DateTime start = DateTime.parse(model[EventFields.startDate.name]);
      DateTime end = DateTime.parse(model[EventFields.endDate.name]);

      if (start.difference(event.startDate) <= const Duration(seconds: 1) &&
          end.difference(event.endDate) <= const Duration(seconds: 1)) {
        data = model;
        break;
      }
    }
    if (data == null) return null;
    event = EventModel.fromJson(data);
    event = await _save(event);
    return event;
  }

  /// If [forceGet] is true, the localDatabase is cleared and new data is fetched
  /// Else only the users not in database are fetched
  static Stream<List<EventModel>> get(
      {String? eventID, String? clubID, bool forceGet = false}) async* {
    List<EventModel> filteredEvents = [];

    // Local Data
    Map localEvents = await LocalDatabase.get(
          LocalCollections.event,
          LocalDocuments.events,
        ) ??
        {};
    if (forceGet) {
      await LocalDatabase.deleteCollection(LocalCollections.event);
      localEvents = {};
    } else {
      if (localEvents.isNotEmpty) {
        if (localEvents.containsKey(eventID)) {
          filteredEvents.add(EventModel.fromJson(
            Formatter.convertMapToMapStringDynamic(localEvents[eventID])!,
          ));
          yield filteredEvents;
        } else {
          for (dynamic key in localEvents.keys) {
            localEvents[key] =
                Formatter.convertMapToMapStringDynamic(localEvents[key]);
            if (localEvents[key] != null &&
                localEvents[key][EventFields.clubID.name] == clubID) {
              filteredEvents.add(EventModel.fromJson(localEvents[key]));
            }
          }
          yield filteredEvents;
        }
      }
    }
    // Server data
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
    filteredEvents = res.map((model) => EventModel.fromJson(model)).toList();
    for (int i = 0; i < filteredEvents.length; i++) {
      filteredEvents[i] = await _save(filteredEvents[i]);
    }
    yield filteredEvents;
  }

  static Future<EventModel> update(EventModel event) async {
    DbCollection collection = Database.instance.collection(_collectionName);
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(EventFields.id.name, event.id);
    if ((await collection.findOne(selectorBuilder)) == null) {
      throw Exception("Event not found");
    }
    await collection.updateOne(selectorBuilder, event);
    event = await _save(event);
    return event;
  }

  static Future<void> delete(String eventID) async {
    DbCollection collection = Database.instance.collection(_collectionName);
    SelectorBuilder selectorBuilder = SelectorBuilder();
    selectorBuilder.eq(EventFields.id.name, eventID);
    if ((await collection.findOne(selectorBuilder)) == null) {
      throw Exception("Event not found");
    }
    await collection.deleteOne(selectorBuilder);
    _delete(eventID);
  }
}
