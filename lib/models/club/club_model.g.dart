// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubModelImpl _$$ClubModelImplFromJson(Map<String, dynamic> json) =>
    _$ClubModelImpl(
      id: json['_id'] as String?,
      name: json['name'] as String,
      instituteName: json['instituteName'] as String,
      description: json['description'] as String,
      socials: (json['socials'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry($enumDecode(_$SocialEnumMap, k), e as String),
          ) ??
          const {},
      email: json['email'] as String,
      phoneNumber: const PhoneNumberSerializer()
          .fromJson(json['phoneNumber'] as Map<String, dynamic>?),
      clubLogoURL: json['clubLogoURL'] as String,
      clubStatus:
          $enumDecodeNullable(_$ClubStatusEnumMap, json['clubStatus']) ??
              ClubStatus.requested,
      clubLogoPublicId: json['clubLogoPublicId'] as String?,
      clubBannerURL: json['clubBannerURL'] as String?,
      clubBannerPublicId: json['clubBannerPublicId'] as String?,
      members: (json['members'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      leadPositionID: json['leadPositionID'] as String?,
      followers: (json['followers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lastLocalUpdate: json['lastLocalUpdate'] == null
          ? null
          : DateTime.parse(json['lastLocalUpdate'] as String),
    );

Map<String, dynamic> _$$ClubModelImplToJson(_$ClubModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'instituteName': instance.instituteName,
      'description': instance.description,
      'socials':
          instance.socials.map((k, e) => MapEntry(_$SocialEnumMap[k]!, e)),
      'email': instance.email,
      'phoneNumber': const PhoneNumberSerializer().toJson(instance.phoneNumber),
      'clubLogoURL': instance.clubLogoURL,
      'clubStatus': _$ClubStatusEnumMap[instance.clubStatus]!,
      'clubLogoPublicId': instance.clubLogoPublicId,
      'clubBannerURL': instance.clubBannerURL,
      'clubBannerPublicId': instance.clubBannerPublicId,
      'members': instance.members,
      'leadPositionID': instance.leadPositionID,
      'followers': instance.followers,
      'lastLocalUpdate': instance.lastLocalUpdate?.toIso8601String(),
    };

const _$SocialEnumMap = {
  Social.github: 'github',
  Social.facebook: 'facebook',
  Social.instagram: 'instagram',
  Social.linkedin: 'linkedin',
};

const _$ClubStatusEnumMap = {
  ClubStatus.requested: 'requested',
  ClubStatus.accepted: 'accepted',
  ClubStatus.rejected: 'rejected',
};
