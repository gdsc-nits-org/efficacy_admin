part of '../club_position_controller.dart';

Future<void> _checkDuplicateImpl(ClubPositionModel clubPosition) async {
  DbCollection collection =
      Database.instance.collection(ClubPositionController._collectionName);

  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq(ClubPositionFields.clubID.name, clubPosition.clubID);
  selectorBuilder.eq(ClubPositionFields.position.name, clubPosition.position);

  if (await collection.findOne(selectorBuilder) != null) {
    throw Exception("Club already has a position with the same name");
  }
}
