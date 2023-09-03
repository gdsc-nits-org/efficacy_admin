import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:efficacy_admin/models/utils/utils.dart';
import 'package:efficacy_admin/models/club_position/club_position.dart';

part 'club.freezed.dart';
part 'club.g.dart';

@freezed
class Club with _$Club {
  const factory Club({
    required String description,
    @Default({}) Map<Social, String> socials,
    required String email,
    @PhoneNumberSerializer() PhoneNumber? phoneNumber,
    required String clubLogoURL,
    String? clubBannerURL,

    /// Map<Position, Member ID>
    required Map<String, String> members,

    /// Follower Ids
    @Default([]) List<String> followers,
  }) = _Club;

  factory Club.fromJson(Map<String, Object?> json) => _$ClubFromJson(json);
}
