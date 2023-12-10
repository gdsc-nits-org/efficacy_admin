import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'institution_model.freezed.dart';
part 'institution_model.g.dart';

@Freezed(fromJson: true, toJson: true)
class InstitutionModel with _$InstitutionModel {
  const InstitutionModel._();
  const factory InstitutionModel({
    @JsonKey(name: "_id") String? id,
    required String name,
    DateTime? lastLocalUpdate,
  }) = _InstitutionModel;

  factory InstitutionModel.fromJson(Map<String, Object?> json) {
    if (json["_id"] != null && json["_id"] is ObjectId) {
      json["_id"] = (json["_id"] as ObjectId).toHexString();
    }
    return _$InstitutionModelFromJson(json);
  }
}

enum InstitutionFields {
  name,
  lastLocalUpdate,
}
