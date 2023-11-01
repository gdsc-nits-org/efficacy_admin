part of '../club_controller.dart';

Stream<List<ClubModel>> _getImpl({
  String? id,
  String? instituteName,
  String? clubName,
  bool forceGet = false,
}) async* {
  if (clubName == null && instituteName == null && id == null) {
    throw ArgumentError("id or instituteName or clubName must be provided");
  }

  List<ClubModel> filteredClubs = [];
  filteredClubs = await _fetchLocal(
    id: id,
    instituteName: instituteName,
    clubName: clubName,
    forceGet: forceGet,
  );

  if (filteredClubs.isNotEmpty) yield filteredClubs;
  filteredClubs = await _fetchFromBackend(
    id: id,
    instituteName: instituteName,
    clubName: clubName,
    forceGet: forceGet,
  );

  yield filteredClubs;
}

Future<List<ClubModel>> _fetchLocal({
  String? id,
  String? instituteName,
  String? clubName,
  bool forceGet = false,
}) async {
  List<ClubModel> filteredClubs = [];
  if (forceGet) {
    await LocalDatabase.deleteKey(LocalDocuments.clubs.name);
  } else {
    List<String> data = LocalDatabase.get(LocalDocuments.clubs.name);
    Map res = data.isEmpty ? {} : jsonDecode(data[0]);

    for (dynamic model in res.values) {
      model = Formatter.convertMapToMapStringDynamic(model);
      if (id != null &&
          model["_id"] == id &&
          !ClubController._isMinified(model)) {
        filteredClubs.add(ClubModel.fromJson(model));
        break;
      } else if (instituteName != null &&
          model[ClubFields.instituteName.name] == instituteName &&
          !ClubController._isMinified(model)) {
        filteredClubs.add(ClubModel.fromJson(model));
      } else if (clubName != null &&
          model[ClubFields.name.name] == clubName &&
          !ClubController._isMinified(model)) {
        filteredClubs.add(ClubModel.fromJson(model));
      }
    }
  }
  return filteredClubs;
}

Future<List<ClubModel>> _fetchFromBackend({
  String? id,
  String? instituteName,
  String? clubName,
  bool forceGet = false,
}) async {
  List<ClubModel> filteredClubs = [];
  DbCollection collection =
      Database.instance.collection(ClubController._collectionName);
  SelectorBuilder selectorBuilder = SelectorBuilder();
  if (id != null) {
    selectorBuilder.eq("_id", ObjectId.parse(id));
  }
  if (instituteName != null) {
    selectorBuilder.eq(ClubFields.instituteName.name, instituteName);
  }
  if (clubName != null) {
    selectorBuilder.eq(ClubFields.name.name, clubName);
  }

  List<Map<String, dynamic>> res =
      await collection.find(selectorBuilder).toList();
  filteredClubs = res.map((model) => ClubModel.fromJson(model)).toList();
  for (int i = 0; i < filteredClubs.length; i++) {
    filteredClubs[i] = await ClubController._save(filteredClubs[i]);
  }
  return filteredClubs;
}
