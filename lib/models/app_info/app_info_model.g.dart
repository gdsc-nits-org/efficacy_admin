// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppInfoModelImpl _$$AppInfoModelImplFromJson(Map<String, dynamic> json) =>
    _$AppInfoModelImpl(
      id: json['_id'] as String?,
      contactEmail: json['contactEmail'] as String,
      adminEmails: (json['adminEmails'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$AppInfoModelImplToJson(_$AppInfoModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'contactEmail': instance.contactEmail,
      'adminEmails': instance.adminEmails,
    };
