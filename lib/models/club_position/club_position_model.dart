import 'package:efficacy_admin/models/utils/objectid_serializer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'club_position_model.freezed.dart';
part 'club_position_model.g.dart';

@freezed
class ClubPositionModel with _$ClubPositionModel {
  const factory ClubPositionModel({
    @JsonKey(name: '_id') @ObjectIdSerializer() ObjectId? id,
    required String clubID,
    required String position,
    DateTime? lastLocalUpdate,
  }) = _ClubPositionModel;

  factory ClubPositionModel.fromJson(Map<String, dynamic> json) =>
      _$ClubPositionModelFromJson(json);
}

enum ClubPositionFields { id, clubID, position, lastLocalUpdate }
