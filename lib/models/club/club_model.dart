import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:efficacy_admin/models/utils/utils.dart';

part 'club_model.freezed.dart';
part 'club_model.g.dart';

@freezed
class ClubModel with _$ClubModel {
  const factory ClubModel({
    @JsonKey(name: '_id') String? id,
    required String name,
    required String instituteName,
    required String description,
    @Default({}) Map<Social, String> socials,
    required String email,
    @PhoneNumberSerializer() PhoneNumber? phoneNumber,
    required String clubLogoURL,
    String? clubBannerURL,

    /// Map<ClubPositionModel, Member Email>
    /// Cannot use clubPositionModel
    /// Since it has issues with freezed (cannot make keys with custom type)
    required Map members,

    /// Follower Ids
    @Default([]) List<String> followers,
  }) = _ClubModel;

  factory ClubModel.fromJson(Map<String, dynamic> json) =>
      _$ClubModelFromJson(json);
}

enum ClubFields {
  id,
  name,
  instituteName,
  description,
  socials,
  email,
  phoneNumber,
  clubLogoURL,
  clubBannerURL,
  members,
  followers,
}
