import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'app_info_model.freezed.dart';
part 'app_info_model.g.dart';

@Freezed(fromJson: true, toJson: true)
class AppInfoModel with _$AppInfoModel {
  const AppInfoModel._();
  const factory AppInfoModel({
    @JsonKey(name: '_id') String? id,
    required String contactEmail,
    required List<String> adminEmails,
  }) = _AppInfoModel;

  factory AppInfoModel.fromJson(Map<String, dynamic> json) {
    if (json["_id"] != null && json["_id"] is ObjectId) {
      json["_id"] = (json["_id"] as ObjectId).toHexString();
    }
    return _$AppInfoModelFromJson(json);
  }
}
