part of '../institution_controller.dart';

Future<void> _checkDuplicateImpl(InstitutionModel institution) async {
  DbCollection collection =
      Database.instance.collection(InstitutionController._collectionName);

  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq(InstitutionFields.name.name, institution.name);

  if (await collection.findOne(selectorBuilder) != null) {
    throw Exception("${institution.name} already exists");
  }
}
