part of '../institution_controller.dart';

Future<InstitutionModel?> _createImpl(InstitutionModel institution) async {
  DbCollection collection =
      Database.instance.collection(InstitutionController._collectionName);

  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq(InstitutionFields.name.name, institution.name);

  await InstitutionController._checkDuplicate(institution);
  await collection.insertOne(institution.toJson());
  Map<String, dynamic>? res = await collection.findOne(selectorBuilder);

  if (res == null) return null;
  institution = InstitutionModel.fromJson(res);
  institution = await InstitutionController._save(institution);
  return institution;
}
