import 'package:efficacy_admin/models/utils/objectid_serializer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:efficacy_admin/models/utils/utils.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'club_model.freezed.dart';
part 'club_model.g.dart';

@freezed
class ClubModel with _$ClubModel {
  const factory ClubModel({
    @ObjectIdSerializer() @JsonKey(name: '_id') ObjectId? id,
    required String name,
    required String instituteName,
    required String description,
    @Default({}) Map<Social, String> socials,
    required String email,
    @PhoneNumberSerializer() PhoneNumber? phoneNumber,
    required String clubLogoURL,
    String? clubBannerURL,

    /// Map<ClubPositionModelID, Member Email>
    /// Cannot use clubPositionModel
    /// Since it has issues with freezed (cannot make keys with custom type)
    required Map members,

    /// Follower Ids
    @Default([]) List<String> followers,
    DateTime? lastLocalUpdate,
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
  lastLocalUpdate
}
