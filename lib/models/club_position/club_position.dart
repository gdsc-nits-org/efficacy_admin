import 'package:freezed_annotation/freezed_annotation.dart';

part 'club_position.freezed.dart';
part 'club_position.g.dart';

@freezed
class ClubPosition with _$ClubPosition {
  const factory ClubPosition({
    required String clubID,
    required String position,
  }) = _ClubPosition;

  factory ClubPosition.fromJson(Map<String, dynamic> json) =>
      _$ClubPositionFromJson(json);
}
