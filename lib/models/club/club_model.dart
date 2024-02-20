import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:efficacy_admin/models/utils/utils.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'club_model.freezed.dart';
part 'club_model.g.dart';

enum ClubStatus { requested, accepted, rejected }

@Freezed(fromJson: true, toJson: true)
class ClubModel with _$ClubModel {
  const ClubModel._();
  const factory ClubModel({
    @JsonKey(name: '_id') String? id,
    required String name,
    required String instituteName,
    required String description,
    @Default({}) Map<Social, String> socials,
    required String email,
    @PhoneNumberSerializer() PhoneNumber? phoneNumber,
    required String clubLogoURL,

    /// This basically tells whether the club was accepted by the developer and
    /// is available for general use or not.
    required ClubStatus clubStatus,
    String? clubLogoPublicId,
    String? clubBannerURL,
    String? clubBannerPublicId,

    /// Map<ClubPositionModelID, List<Member Email>>
    /// Cannot use clubPositionModel
    /// Since it has issues with freezed (cannot make keys with custom type)
    required Map<String, List<String>> members,

    /// ID of the club position of the leader
    /// Required to make sure that all the positions are not deleted
    String? leadPositionID,

    /// Follower Ids
    @Default([]) List<String> followers,
    DateTime? lastLocalUpdate,
  }) = _ClubModel;

  factory ClubModel.fromJson(Map<String, dynamic> json) {
    if (json["_id"] != null && json["_id"] is ObjectId) {
      json["_id"] = (json["_id"] as ObjectId).toHexString();
    }
    return _$ClubModelFromJson(json);
  }

  /// Returns a minified data primary target being the id and name
  /// If the rest of the values are provided they are also stored in the model
  static ClubModel minifiedFromJson(Map<String, dynamic> json) {
    String id = "";
    if (json["_id"] is ObjectId) {
      id = (json["_id"] as ObjectId).toHexString();
    } else {
      id = json["_id"];
    }
    return ClubModel(
      id: id,
      name: json[ClubFields.name.name],
      instituteName: json[ClubFields.instituteName.name],
      description: "",
      socials: {},
      clubStatus: ClubStatus.requested,
      email: "",
      clubLogoURL: "",
      members: {},
      followers: [],
    );
  }

  @override
  bool operator ==(dynamic other) {
    return id != null && other.id != null
        ? (id == other.id)
        : identical(this, other) ||
            (other.runtimeType == runtimeType &&
                other is _$ClubModelImpl &&
                (identical(other.id, id) || other.id == id) &&
                (identical(other.name, name) || other.name == name) &&
                (identical(other.instituteName, instituteName) ||
                    other.instituteName == instituteName) &&
                (identical(other.description, description) ||
                    other.description == description) &&
                const DeepCollectionEquality()
                    .equals(other._socials, socials) &&
                (identical(other.email, email) || other.email == email) &&
                (identical(other.phoneNumber, phoneNumber) ||
                    other.phoneNumber == phoneNumber) &&
                (identical(other.clubLogoURL, clubLogoURL) ||
                    other.clubLogoURL == clubLogoURL) &&
                (identical(other.clubStatus, clubStatus) ||
                    other.clubStatus == clubStatus) &&
                (identical(other.clubLogoPublicId, clubLogoPublicId) ||
                    other.clubLogoPublicId == clubLogoPublicId) &&
                (identical(other.clubBannerURL, clubBannerURL) ||
                    other.clubBannerURL == clubBannerURL) &&
                (identical(other.clubBannerPublicId, clubBannerPublicId) ||
                    other.clubBannerPublicId == clubBannerPublicId) &&
                const DeepCollectionEquality()
                    .equals(other._members, members) &&
                (identical(other.leadPositionID, leadPositionID) ||
                    other.leadPositionID == leadPositionID) &&
                const DeepCollectionEquality()
                    .equals(other._followers, followers) &&
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
          instituteName,
          description,
          const DeepCollectionEquality().hash(socials),
          email,
          phoneNumber,
          clubLogoURL,
          clubStatus,
          clubLogoPublicId,
          clubBannerURL,
          clubBannerPublicId,
          const DeepCollectionEquality().hash(members),
          leadPositionID,
          const DeepCollectionEquality().hash(followers),
          lastLocalUpdate);
}

enum ClubFields {
  name,
  instituteName,
  description,
  socials,
  email,
  phoneNumber,
  clubLogoURL,
  clubStatus,
  clubLogoPublicId,
  clubBannerURL,
  clubBannerPublicId,
  members,
  leadPositionID,
  followers,
  lastLocalUpdate
}
