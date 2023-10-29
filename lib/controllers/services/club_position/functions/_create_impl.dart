part of '../club_position_controller.dart';

Future<ClubPositionModel?> _createImpl(ClubPositionModel clubPosition) async {
  DbCollection collection =
      Database.instance.collection(ClubPositionController._collectionName);
  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq(ClubPositionFields.clubID.name, clubPosition.clubID);
  selectorBuilder.eq(ClubPositionFields.position.name, clubPosition.position);

  await ClubPositionController._checkDuplicate(clubPosition);
  await collection.insertOne(clubPosition.toJson());
  Map<String, dynamic>? res = await collection.findOne(selectorBuilder);

  if (res == null) return null;
  clubPosition = ClubPositionModel.fromJson(res);
  clubPosition = await ClubPositionController._save(clubPosition);
  return clubPosition;
}
