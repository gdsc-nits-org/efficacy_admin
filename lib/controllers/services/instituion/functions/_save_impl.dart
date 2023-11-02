part of '../institution_controller.dart';

Future<InstitutionModel> _saveImpl(InstitutionModel institution) async {
  List<String> data = LocalDatabase.get(LocalDocuments.institutions.name);

  Map institutions = data.isEmpty ? {} : jsonDecode(data[0]);
  institution = institution.copyWith(lastLocalUpdate: DateTime.now());
  institutions[institution.id] = institution.toJson();

  await LocalDatabase.set(
    LocalDocuments.institutions.name,
    [jsonEncode(institutions)],
  );
  return institution;
}
