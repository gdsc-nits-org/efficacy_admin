part of '../institution_controller.dart';

Future<List<InstitutionModel>> _getAllInstitutionsImpl() async {
  List<InstitutionModel> filteredInstitutions = [];

  DbCollection collection =
      Database.instance.collection(InstitutionController._collectionName);
  SelectorBuilder selectorBuilder = SelectorBuilder();

  List<Map<String, dynamic>> listResponse =
      await collection.find(selectorBuilder).toList();
  filteredInstitutions = [];
  for (Map<String, dynamic> val in listResponse) {
    InstitutionModel institution = InstitutionModel.fromJson(val);
    institution = await InstitutionController._save(institution);
    filteredInstitutions.add(institution);
  }
  return filteredInstitutions;
}
