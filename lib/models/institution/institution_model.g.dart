// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'institution_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InstitutionModelImpl _$$InstitutionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InstitutionModelImpl(
      id: json['_id'] as String?,
      name: json['name'] as String,
      lastLocalUpdate: json['lastLocalUpdate'] == null
          ? null
          : DateTime.parse(json['lastLocalUpdate'] as String),
    );

Map<String, dynamic> _$$InstitutionModelImplToJson(
        _$InstitutionModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'lastLocalUpdate': instance.lastLocalUpdate?.toIso8601String(),
    };
