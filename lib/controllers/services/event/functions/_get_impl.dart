part of "../event_controller.dart";

Stream<List<EventModel>> _getImpl({
  String? eventID,
  String? clubID,
  bool forceGet = false,
}) async* {
  List<EventModel> filteredEvents = await _fetchLocal(
    eventID: eventID,
    clubID: clubID,
    forceGet: forceGet,
  );
  if (filteredEvents.isNotEmpty) yield filteredEvents;

  filteredEvents = await _fetchFromBackend(
    eventID: eventID,
    clubID: clubID,
    forceGet: forceGet,
  );
  yield filteredEvents;
}

Future<List<EventModel>> _fetchLocal({
  String? eventID,
  String? clubID,
  bool forceGet = false,
}) async {
  List<EventModel> filteredEvents = [];

  List<String> data = LocalDatabase.get(LocalDocuments.events.name);
  // Local Data
  Map localEvents = data.isEmpty ? {} : jsonDecode(data[0]);
  if (forceGet) {
    await LocalDatabase.deleteKey(LocalDocuments.events.name);
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
    }
  }
  return filteredEvents;
}

Future<List<EventModel>> _fetchFromBackend({
  String? eventID,
  String? clubID,
  bool forceGet = false,
}) async {
  List<EventModel> filteredEvents = [];
  // Server data
  DbCollection collection =
      Database.instance.collection(EventController._collectionName);

  SelectorBuilder selectorBuilder = SelectorBuilder();
  if (eventID != null) {
    selectorBuilder.eq("_id", ObjectId.parse(eventID));
  } else if (clubID != null) {
    selectorBuilder.eq(EventFields.clubID.name, clubID);
  } else {
    throw ArgumentError("EventID or clubID is required");
  }

  List<Map<String, dynamic>> res =
      await collection.find(selectorBuilder).toList();
  filteredEvents = res.map((model) => EventModel.fromJson(model)).toList();
  for (int i = 0; i < filteredEvents.length; i++) {
    filteredEvents[i] = await EventController._save(filteredEvents[i]);
  }
  return filteredEvents;
}
