part of '../club_controller.dart';

Future<ClubModel> _saveImpl(ClubModel club) async {
  Map? clubs = await LocalDatabase.get(
    LocalCollections.club,
    LocalDocuments.clubs,
  );
  clubs ??= {};
  club = club.copyWith(lastLocalUpdate: DateTime.now());
  clubs[club.id] = club.toJson();
  await LocalDatabase.set(
    LocalCollections.club,
    LocalDocuments.clubs,
    clubs,
  );
  return club;
}
