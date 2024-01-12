import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:efficacy_admin/models/utils/utils.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

const String appName = "Efficacy Admin";

@Freezed(fromJson: true, toJson: true)
class UserModel with _$UserModel {
  const UserModel._();
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

  @override
  bool operator ==(dynamic other) {
    return id != null && other.id != null
        ? (id == other.id)
        : identical(this, other) ||
            (other.runtimeType == runtimeType &&
                other is _$UserModelImpl &&
                (identical(other.id, id) || other.id == id) &&
                (identical(other.name, name) || other.name == name) &&
                (identical(other.phoneNumber, phoneNumber) ||
                    other.phoneNumber == phoneNumber) &&
                (identical(other.password, password) ||
                    other.password == password) &&
                (identical(other.email, email) || other.email == email) &&
                (identical(other.scholarID, scholarID) ||
                    other.scholarID == scholarID) &&
                (identical(other.userPhoto, userPhoto) ||
                    other.userPhoto == userPhoto) &&
                (identical(other.userPhotoPublicID, userPhotoPublicID) ||
                    other.userPhotoPublicID == userPhotoPublicID) &&
                (identical(other.branch, branch) || other.branch == branch) &&
                (identical(other.degree, degree) || other.degree == degree) &&
                const DeepCollectionEquality().equals(other.socials, socials) &&
                (identical(other.app, app) || other.app == app) &&
                const DeepCollectionEquality()
                    .equals(other.position, position) &&
                const DeepCollectionEquality()
                    .equals(other.following, following) &&
                (identical(other.lastLocalUpdate, lastLocalUpdate) ||
                    other.lastLocalUpdate == lastLocalUpdate));
  }

  @override
  int get hashCode => id != null
      ? Object.hash(runtimeType, id)
      : Object.hash(
          runtimeType,
          id,
          name,
          phoneNumber,
          password,
          email,
          scholarID,
          userPhoto,
          userPhotoPublicID,
          branch,
          degree,
          const DeepCollectionEquality().hash(socials),
          app,
          const DeepCollectionEquality().hash(position),
          const DeepCollectionEquality().hash(following),
          lastLocalUpdate);
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
