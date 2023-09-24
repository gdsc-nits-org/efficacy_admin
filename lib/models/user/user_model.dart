import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:efficacy_admin/models/utils/utils.dart';
import 'package:efficacy_admin/models/club_position/club_position_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String name,
    @PhoneNumberSerializer() PhoneNumber? phoneNumber,
    required String email,
    required String scholarID,
    String? userPhoto,
    required Branch branch,
    required Degree degree,
    @Default({}) Map<Social, String> socials,
    @Default([]) List<ClubPositionModel> position,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}
