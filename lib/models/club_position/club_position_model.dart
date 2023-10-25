import 'package:efficacy_admin/models/utils/constants.dart';
import 'package:efficacy_admin/models/utils/objectid_serializer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'club_position_model.freezed.dart';
part 'club_position_model.g.dart';

@Freezed(fromJson: true, toJson: true)
class ClubPositionModel with _$ClubPositionModel {
  const factory ClubPositionModel({
    @JsonKey(name: '_id') String? id,
    required String clubID,
    required String position,
    DateTime? lastLocalUpdate,
    @Default([]) List<Permission> permissions,
  }) = _ClubPositionModel;

  factory ClubPositionModel.fromJson(Map<String, dynamic> json) {
    if (json["_id"] != null && json["_id"] is ObjectId) {
      json["_id"] = (json["_id"] as ObjectId).toHexString();
    }
    return _$ClubPositionModelFromJson(json);
  }
}

enum ClubPositionFields { id, clubID, position, lastLocalUpdate }
