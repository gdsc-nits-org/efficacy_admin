part of '../club_controller.dart';

Future<List<ClubModel>> _getRequestedClubsImpl() async {
  if (!(await UserController.isCurrentUserAnAdmin())) {
    throw Exception(
        "You do not have enough privileges to access the operation.");
  }
  List<ClubModel> filteredClubs = [];
  DbCollection collection =
      Database.instance.collection(ClubController._collectionName);
  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq(ClubFields.clubStatus.name, ClubStatus.requested.name);

  List<Map<String, dynamic>> res =
      await collection.find(selectorBuilder).toList();
  filteredClubs = res.map((model) => ClubModel.fromJson(model)).toList();
  for (int i = 0; i < filteredClubs.length; i++) {
    filteredClubs[i] = await ClubController._save(filteredClubs[i]);
  }
  return filteredClubs;
}
