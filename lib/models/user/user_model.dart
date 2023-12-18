import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:efficacy_admin/models/utils/utils.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

const String appName = "Efficacy Admin";

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
    String? userPhotoPublicID,
    required Branch branch,
    required Degree degree,
    @Default({}) Map<Social, String> socials,

    /// Which app does this user instance belong to
    /// No need to touch this
    @Default(appName) String app,

    /// List<ClubPositionID>
    @Default([]) List<String> position,

    /// List<ClubID>
    @Default([]) List<String> following,
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
  name,
  phoneNumber,
  password,
  email,
  scholarID,
  userPhoto,
  branch,
  degree,
  socials,
  app,
  positions,
  lastLocalUpdate
}
