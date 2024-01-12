import 'package:efficacy_admin/models/utils/constants.dart';
import 'package:efficacy_admin/models/utils/objectid_serializer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'club_position_model.freezed.dart';
part 'club_position_model.g.dart';

@Freezed(fromJson: true, toJson: true)
class ClubPositionModel with _$ClubPositionModel {
  const ClubPositionModel._();
  const factory ClubPositionModel({
    @JsonKey(name: '_id') String? id,
    required String clubID,
    required String position,
    DateTime? lastLocalUpdate,
    @Default([]) List<Permissions> permissions,
  }) = _ClubPositionModel;

  factory ClubPositionModel.fromJson(Map<String, dynamic> json) {
    if (json["_id"] != null && json["_id"] is ObjectId) {
      json["_id"] = (json["_id"] as ObjectId).toHexString();
    }
    return _$ClubPositionModelFromJson(json);
  }

  @override
  bool operator ==(dynamic other) {
    return id != null && other.id != null
        ? (id == other.id)
        : identical(this, other) ||
            (other.runtimeType == runtimeType &&
                other is _$ClubPositionModelImpl &&
                (identical(other.id, id) || other.id == id) &&
                (identical(other.clubID, clubID) || other.clubID == clubID) &&
                (identical(other.position, position) ||
                    other.position == position) &&
                (identical(other.lastLocalUpdate, lastLocalUpdate) ||
                    other.lastLocalUpdate == lastLocalUpdate) &&
                const DeepCollectionEquality()
                    .equals(other._permissions, permissions));
  }

  @override
  int get hashCode => id != null
      ? Object.hash(runtimeType, id)
      : Object.hash(runtimeType, id, clubID, position, lastLocalUpdate,
          const DeepCollectionEquality().hash(permissions));
}

enum ClubPositionFields {
  id,
  clubID,
  position,
  lastLocalUpdate,
  permissions,
}
