part of '../club_controller.dart';

Future<ClubModel?> _createImpl(ClubModel club) async {
  DbCollection collection =
      Database.instance.collection(ClubController._collectionName);

  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq(ClubFields.instituteName.name, club.instituteName);
  selectorBuilder.eq(ClubFields.name.name, club.name);

  await ClubController._checkDuplicate(club);
  await collection.insertOne(club.toJson());
  Map<String, dynamic>? res = await collection.findOne(selectorBuilder);

  if (res == null) return null;
  club = ClubModel.fromJson(res);
  club = await ClubController._save(club);
  return club;
}
