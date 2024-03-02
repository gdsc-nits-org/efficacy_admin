part of '../club_controller.dart';

Future<void> _checkDuplicateImpl(ClubModel club) async {
  DbCollection collection =
      Database.instance.collection(ClubController._collectionName);

  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq(ClubFields.instituteName.name, club.instituteName);
  selectorBuilder.eq(ClubFields.name.name, club.name);
  selectorBuilder.eq(ClubFields.clubStatus.name, ClubStatus.accepted.name);

  Map<String, dynamic>? res = await collection.findOne(selectorBuilder);
  ClubModel? temp;
  if (res != null) {
    temp = ClubModel.fromJson(Formatter.convertMapToMapStringDynamic(res)!);
  }
  if (res != null && temp?.id != club.id) {
    throw Exception("Club with same name exists at ${club.instituteName}");
  }
}
