part of '../club_position_controller.dart';

Future<void> _checkDuplicateImpl(ClubPositionModel clubPosition) async {
  DbCollection collection =
      Database.instance.collection(ClubPositionController._collectionName);

  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq(ClubPositionFields.clubID.name, clubPosition.clubID);
  selectorBuilder.eq(ClubPositionFields.position.name, clubPosition.position);

  Map? res = await collection.findOne(selectorBuilder);
  ClubPositionModel? temp;
  if (res != null) {
    temp = ClubPositionModel.fromJson(
        Formatter.convertMapToMapStringDynamic(res)!);
  }
  if (res != null && temp?.id != clubPosition.id) {
    throw Exception("Club already has a position with the same name");
  }
}
