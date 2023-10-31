part of '../club_position_controller.dart';

Future<ClubPositionModel> _saveImpl(ClubPositionModel position) async {
  Map? positions = await LocalDatabase.get(
      LocalCollections.clubPosition, LocalDocuments.clubPositions);
  positions ??= {};
  position = position.copyWith(lastLocalUpdate: DateTime.now());
  positions[position.id] = position.toJson();
  await LocalDatabase.set(
    LocalCollections.clubPosition,
    LocalDocuments.clubPositions,
    positions,
  );
  return position;
}
