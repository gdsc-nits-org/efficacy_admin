part of '../institution_controller.dart';

Stream<InstitutionModel?> _getImpl({
  required String id,
  bool forceGet = false,
}) async* {
  InstitutionModel? filteredInstitutions =
      await _fetchLocal(id: id, forceGet: forceGet);
  if (filteredInstitutions != null) yield filteredInstitutions;

  filteredInstitutions = await _fetchFromBackend(id: id);
  yield filteredInstitutions;
}

Future<InstitutionModel?> _fetchLocal({
  required String id,
  bool forceGet = false,
}) async {
  if (forceGet) {
    await LocalDatabase.deleteKey(LocalDocuments.institutions.name);
  } else {
    List<String> data = LocalDatabase.get(LocalDocuments.institutions.name);
    Map res = data.isEmpty ? {} : jsonDecode(data[0]);

    if (res.containsKey(id)) {
      return InstitutionModel.fromJson(res[id]);
    }
  }
  return null;
}

Future<InstitutionModel?> _fetchFromBackend({
  required String id,
  bool forceGet = false,
}) async {
  DbCollection collection =
      Database.instance.collection(InstitutionController._collectionName);
  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq("_id", ObjectId.parse(id));

  Map<String, dynamic>? res = await collection.findOne(selectorBuilder);
  if (res == null) return null;

  return await InstitutionController._save(InstitutionModel.fromJson(res));
}
