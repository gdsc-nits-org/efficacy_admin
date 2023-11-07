part of '../club_controller.dart';

Future<ClubModel> _updateImpl(ClubModel club) async {
  DbCollection collection =
      Database.instance.collection(ClubController._collectionName);
  if (club.id == null) {
    throw Exception("Couldn't find club");
  }
  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq("_id", ObjectId.parse(club.id!));

  List<ClubModel> oldData =
      await ClubController.get(id: club.id, forceGet: true).first;

  if (oldData.isEmpty) {
    throw Exception("Couldn't find club");
  } else {
    if (oldData.first.instituteName != club.instituteName ||
        oldData.first.name != club.name) {
      await ClubController._checkDuplicate(club);
    }
    await collection.update(
      selectorBuilder,
      compare(
        oldData.first.toJson(),
        club.toJson(),
      ).map,
    );
    club = await ClubController._save(club);
    return club;
  }
}
