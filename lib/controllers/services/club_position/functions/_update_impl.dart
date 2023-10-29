part of '../club_position_controller.dart';

Future<ClubPositionModel> _updateImpl(
    ClubPositionModel clubPositionModel) async {
  // Since the only editable field is position name its check is necessary
  await ClubPositionController._checkDuplicate(clubPositionModel);
  DbCollection collection =
      Database.instance.collection(ClubPositionController._collectionName);

  List<ClubPositionModel> oldData = await ClubPositionController.get(
    clubPositionID: clubPositionModel.id,
    forceGet: true,
  ).first;
  if (oldData.isEmpty) {
    throw Exception("Couldn't find club position");
  }
  SelectorBuilder selector = SelectorBuilder();
  selector.eq("_id", ObjectId.parse(clubPositionModel.id!));

  await collection.updateOne(
    selector,
    compare(
      oldData.first.toJson(),
      clubPositionModel.toJson(),
      ignore: [ClubPositionFields.clubID.name],
    ).map,
  );
  return await ClubPositionController._save(clubPositionModel);
}
