import 'package:freezed_annotation/freezed_annotation.dart';

part 'club_position_model.freezed.dart';
part 'club_position_model.g.dart';

@freezed
class ClubPositionModel with _$ClubPositionModel {
  const factory ClubPositionModel({
    @JsonKey(name: '_id') String? id,
    required String clubID,
    required String position,
  }) = _ClubPositionModel;

  factory ClubPositionModel.fromJson(Map<String, dynamic> json) =>
      _$ClubPositionModelFromJson(json);
}
