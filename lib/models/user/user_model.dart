import 'package:efficacy_admin/models/utils/objectid_serializer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:efficacy_admin/models/utils/utils.dart';
import 'package:efficacy_admin/models/club_position/club_position_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @ObjectIdSerializer() @JsonKey(name: '_id') ObjectId? id,
    required String name,
    @PhoneNumberSerializer() PhoneNumber? phoneNumber,
    required String password,
    required String email,
    required String scholarID,
    String? userPhoto,
    required Branch branch,
    required Degree degree,
    @Default({}) Map<Social, String> socials,
    @Default([]) List<ClubPositionModel> position,
    DateTime? lastLocalUpdate,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}

enum UserFields {
  id,
  name,
  phoneNumber,
  email,
  scholarID,
  userPhoto,
  branch,
  degree,
  socials,
  positions
}
