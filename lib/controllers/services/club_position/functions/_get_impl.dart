part of '../club_position_controller.dart';

Stream<List<ClubPositionModel>> _getImpl(
    {String? clubPositionID, String? clubID, bool forceGet = false}) async* {
  List<ClubPositionModel> filteredClubPositions = [];
  if (clubID == null && clubPositionID == null) {
    throw ArgumentError("Club Position ID or club id is required");
  }

  await ClubPositionController._checkPermission(
    clubID: clubID!,
    forView: true,
  );
  filteredClubPositions = await _fetchLocal(
    clubPositionID: clubPositionID,
    clubID: clubID,
    forceGet: forceGet,
  );
  if (filteredClubPositions.isNotEmpty) yield filteredClubPositions;

  filteredClubPositions = await _fetchFromBackend(
    clubPositionID: clubPositionID,
    clubID: clubID,
  );
  yield filteredClubPositions;
}

Future<List<ClubPositionModel>> _fetchLocal({
  String? clubPositionID,
  String? clubID,
  bool forceGet = false,
}) async {
  List<ClubPositionModel> filteredClubPositions = [];

  if (forceGet) {
    await LocalDatabase.deleteKey(
      LocalCollections.clubPosition,
      LocalDocuments.clubPositions,
    );
  } else {
    Map? res = await LocalDatabase.get(
      LocalCollections.clubPosition,
      LocalDocuments.clubPositions,
    );
    if (res != null) {
      if (clubPositionID != null && res.containsKey(clubPositionID)) {
        return [
          ClubPositionModel.fromJson(
            Formatter.convertMapToMapStringDynamic(res[clubPositionID])!,
          )
        ];
      } else if (clubID != null) {
        for (dynamic model in res.values) {
          model = Formatter.convertMapToMapStringDynamic(model);
          if (model[ClubPositionFields.clubID.name] == clubID) {
            filteredClubPositions.add(ClubPositionModel.fromJson(model));
          }
        }
      }
    }
  }
  return filteredClubPositions;
}

Future<List<ClubPositionModel>> _fetchFromBackend({
  String? clubPositionID,
  String? clubID,
  bool forceGet = false,
}) async {
  List<ClubPositionModel> filteredClubPositions = [];

  SelectorBuilder selector = SelectorBuilder();
  if (clubPositionID != null) {
    selector.eq("_id", ObjectId.parse(clubPositionID));
  } else if (clubID != null) {
    selector.eq(ClubPositionFields.clubID.name, clubID);
  }

  DbCollection collection =
      Database.instance.collection(ClubPositionController._collectionName);

  List<Map<String, dynamic>> res = await collection.find(selector).toList();
  filteredClubPositions =
      res.map((model) => ClubPositionModel.fromJson(model)).toList();
  for (int i = 0; i < filteredClubPositions.length; i++) {
    filteredClubPositions[i] =
        await ClubPositionController._save(filteredClubPositions[i]);
  }
  return filteredClubPositions;
}
