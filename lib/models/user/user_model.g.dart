// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      name: json['name'] as String,
      phoneNumber: _$JsonConverterFromJson<Map<String, String?>, PhoneNumber>(
          json['phoneNumber'], const PhoneNumberSerializer().fromJson),
      email: json['email'] as String,
      scholarID: json['scholarID'] as String,
      userPhoto: json['userPhoto'] as String?,
      branch: $enumDecode(_$BranchEnumMap, json['branch']),
      degree: $enumDecode(_$DegreeEnumMap, json['degree']),
      socials: (json['socials'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry($enumDecode(_$SocialEnumMap, k), e as String),
          ) ??
          const {},
      position: (json['position'] as List<dynamic>?)
              ?.map(
                  (e) => ClubPositionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phoneNumber': _$JsonConverterToJson<Map<String, String?>, PhoneNumber>(
          instance.phoneNumber, const PhoneNumberSerializer().toJson),
      'email': instance.email,
      'scholarID': instance.scholarID,
      'userPhoto': instance.userPhoto,
      'branch': _$BranchEnumMap[instance.branch]!,
      'degree': _$DegreeEnumMap[instance.degree]!,
      'socials':
          instance.socials.map((k, e) => MapEntry(_$SocialEnumMap[k]!, e)),
      'position': instance.position,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

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

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
