import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:efficacy_admin/models/utils/utils.dart';
import 'package:efficacy_admin/models/club_position/club_position.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String name,
    @PhoneNumberSerializer() PhoneNumber? phoneNumber,
    required String email,
    required String scholarID,
    String? userPhoto,
    required Branch branch,
    required Degree degree,
    @Default({}) Map<Social, String> socials,
    @Default([]) List<ClubPosition> position,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
