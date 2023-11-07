// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['_id'] as String?,
      name: json['name'] as String,
      phoneNumber: const PhoneNumberSerializer()
          .fromJson(json['phoneNumber'] as Map<String, dynamic>?),
      password: json['password'] as String?,
      email: json['email'] as String,
      scholarID: json['scholarID'] as String,
      userPhoto: json['userPhoto'] as String?,
      userPhotoPublicID: json['userPhotoPublicID'] as String?,
      branch: $enumDecode(_$BranchEnumMap, json['branch']),
      degree: $enumDecode(_$DegreeEnumMap, json['degree']),
      socials: (json['socials'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry($enumDecode(_$SocialEnumMap, k), e as String),
          ) ??
          const {},
      position: (json['position'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lastLocalUpdate: json['lastLocalUpdate'] == null
          ? null
          : DateTime.parse(json['lastLocalUpdate'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phoneNumber': const PhoneNumberSerializer().toJson(instance.phoneNumber),
      'password': instance.password,
      'email': instance.email,
      'scholarID': instance.scholarID,
      'userPhoto': instance.userPhoto,
      'userPhotoPublicID': instance.userPhotoPublicID,
      'branch': _$BranchEnumMap[instance.branch]!,
      'degree': _$DegreeEnumMap[instance.degree]!,
      'socials':
          instance.socials.map((k, e) => MapEntry(_$SocialEnumMap[k]!, e)),
      'position': instance.position,
      'lastLocalUpdate': instance.lastLocalUpdate?.toIso8601String(),
    };

const _$BranchEnumMap = {
  Branch.CE: 'CE',
  Branch.CSE: 'CSE',
  Branch.ECE: 'ECE',
  Branch.EIE: 'EIE',
  Branch.EE: 'EE',
  Branch.ME: 'ME',
};

const _$DegreeEnumMap = {
  Degree.BTech: 'BTech',
  Degree.MTech: 'MTech',
  Degree.Phd: 'Phd',
};

const _$SocialEnumMap = {
  Social.github: 'github',
  Social.facebook: 'facebook',
  Social.instagram: 'instagram',
  Social.linkedin: 'linkedin',
};
