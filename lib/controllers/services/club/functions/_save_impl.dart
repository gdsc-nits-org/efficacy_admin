part of '../club_controller.dart';

Future<ClubModel> _saveImpl(ClubModel club) async {
  List<String> data = LocalDatabase.get(LocalDocuments.clubs.name);

  Map clubs = data.isEmpty ? {} : jsonDecode(data[0]);
  club = club.copyWith(lastLocalUpdate: DateTime.now());
  clubs[club.id] = club.toJson();

  await LocalDatabase.set(
    LocalDocuments.clubs.name,
    [jsonEncode(clubs)],
  );
  return club;
}
