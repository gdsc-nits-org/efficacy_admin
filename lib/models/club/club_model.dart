import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:efficacy_admin/models/utils/utils.dart';

part 'club_model.freezed.dart';
part 'club_model.g.dart';

@freezed
class ClubModel with _$ClubModel {
  const factory ClubModel({
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
  }) = _ClubModel;

  factory ClubModel.fromJson(Map<String, Object?> json) =>
      _$ClubModelFromJson(json);
}
