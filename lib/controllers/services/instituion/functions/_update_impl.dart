part of '../institution_controller.dart';

Future<InstitutionModel> _updateImpl(InstitutionModel institution) async {
  DbCollection collection =
      Database.instance.collection(InstitutionController._collectionName);
  if (institution.id == null) {
    throw Exception("Couldn't find club");
  }
  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq("_id", ObjectId.parse(institution.id!));

  InstitutionModel? oldData =
      await InstitutionController.get(id: institution.id!, forceGet: true)
          .first;

  if (oldData == null) {
    throw Exception("Couldn't find institution");
  } else {
    if (oldData.name != institution.name) {
      await InstitutionController._checkDuplicate(institution);
    }
    await collection.update(
      selectorBuilder,
      compare(
        oldData.toJson(),
        institution.toJson(),
      ).map,
    );
    institution = await InstitutionController._save(institution);
    return institution;
  }
}
