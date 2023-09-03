import 'package:efficacy_admin/models/club_position/club_position.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ClubPositionSerializer
    implements JsonConverter<ClubPosition, Map<String, String>> {
  const ClubPositionSerializer();

  @override
  ClubPosition fromJson(Map<String, String> json) {
    if (json['clubID'] == null || json['position'] == null) {
      throw MissingRequiredKeysException(['clubID', 'position'], json);
    }
    return ClubPosition(
      clubID: json['clubID']!,
      position: json['position']!,
    );
  }

  @override
  Map<String, String> toJson(ClubPosition position) {
    return {
      'clubID': position.clubID,
      'position': position.position,
    };
  }
}
