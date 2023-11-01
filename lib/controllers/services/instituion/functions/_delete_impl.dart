part of '../institution_controller.dart';

Future<void> _deleteImpl({String? id, String? name}) async {
  DbCollection collection =
      Database.instance.collection(InstitutionController._collectionName);

  SelectorBuilder selectorBuilder = SelectorBuilder();
  if (id != null) {
    selectorBuilder.eq("_id", ObjectId.parse(id));
  } else if (name != null) {
    selectorBuilder.eq(InstitutionFields.name.name, name);
  } else {
    throw ArgumentError("Either id or name is required");
  }
  Map<String, dynamic>? res = await collection.findOne(selectorBuilder);
  if (res == null) {
    throw Exception("Institution not found");
  }
  await collection.deleteOne(selectorBuilder);
  await InstitutionController._deleteLocal(id ?? res["_id"]);
}
