import 'package:efficacy_admin/models/club_position/club_position_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class ClubPositionSerializer
    implements JsonConverter<ClubPositionModel, Map<String, String>> {
  const ClubPositionSerializer();

  @override
  ClubPositionModel fromJson(Map<String, String> json) {
    if (json['clubID'] == null || json['position'] == null) {
      throw MissingRequiredKeysException(['clubID', 'position'], json);
    }
    return ClubPositionModel(
      clubID: json['clubID']!,
      position: json['position']!,
    );
  }

  @override
  Map<String, String> toJson(ClubPositionModel position) {
    return {
      'clubID': position.clubID,
      'position': position.position,
    };
  }
}
