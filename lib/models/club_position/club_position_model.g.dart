// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_position_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClubPositionModel _$$_ClubPositionModelFromJson(Map<String, dynamic> json) =>
    _$_ClubPositionModel(
      id: json['_id'] as String?,
      clubID: json['clubID'] as String,
      position: json['position'] as String,
      lastLocalUpdate: json['lastLocalUpdate'] == null
          ? null
          : DateTime.parse(json['lastLocalUpdate'] as String),
    );

Map<String, dynamic> _$$_ClubPositionModelToJson(
        _$_ClubPositionModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'clubID': instance.clubID,
      'position': instance.position,
      'lastLocalUpdate': instance.lastLocalUpdate?.toIso8601String(),
    };
