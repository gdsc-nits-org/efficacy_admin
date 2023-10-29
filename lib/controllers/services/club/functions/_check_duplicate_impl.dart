part of '../club_controller.dart';

Future<void> _checkDuplicateImpl(ClubModel club) async {
  DbCollection collection =
      Database.instance.collection(ClubController._collectionName);

  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq(ClubFields.instituteName.name, club.instituteName);
  selectorBuilder.eq(ClubFields.name.name, club.name);

  if (await collection.findOne(selectorBuilder) != null) {
    throw Exception("Club with same name exists at ${club.instituteName}");
  }
}
