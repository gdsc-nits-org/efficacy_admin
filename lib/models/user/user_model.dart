import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:efficacy_admin/models/utils/utils.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@Freezed(fromJson: true, toJson: true)
class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: '_id') String? id,
    required String name,
    @PhoneNumberSerializer() PhoneNumber? phoneNumber,
    String? password,
    required String email,
    required String scholarID,
    String? userPhoto,
    required Branch branch,
    required Degree degree,
    @Default({}) Map<Social, String> socials,
    @Default([]) List<String> position,
    DateTime? lastLocalUpdate,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) {
    if (json["_id"] != null && json["_id"] is ObjectId) {
      json["_id"] = (json["_id"] as ObjectId).toHexString();
    }
    return _$UserModelFromJson(json);
  }
}

enum UserFields {
  id,
  name,
  phoneNumber,
  password,
  email,
  scholarID,
  userPhoto,
  branch,
  degree,
  socials,
  positions,
  lastLocalUpdate
}
