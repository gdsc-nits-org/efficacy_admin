part of '../institution_controller.dart';

Future<void> _checkDuplicateImpl(InstitutionModel institution) async {
  DbCollection collection =
      Database.instance.collection(InstitutionController._collectionName);

  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq(InstitutionFields.name.name, institution.name);

  Map? res = await collection.findOne(selectorBuilder);
  InstitutionModel? temp;
  if (res != null) {
    temp =
        InstitutionModel.fromJson(Formatter.convertMapToMapStringDynamic(res)!);
  }
  if (res != null && temp?.id != institution.id) {
    throw Exception("${institution.name} already exists");
  }
}
