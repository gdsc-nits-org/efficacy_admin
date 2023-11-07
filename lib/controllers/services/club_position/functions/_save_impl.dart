part of '../club_position_controller.dart';

Future<ClubPositionModel> _saveImpl(ClubPositionModel position) async {
  List<String> data = LocalDatabase.get(LocalDocuments.clubPositions.name);

  Map positions = data.isEmpty ? {} : jsonDecode(data[0]);
  position = position.copyWith(lastLocalUpdate: DateTime.now());
  positions[position.id] = position.toJson();

  await LocalDatabase.set(
    LocalDocuments.clubPositions.name,
    [jsonEncode(positions)],
  );
  return position;
}
