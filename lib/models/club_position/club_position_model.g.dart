// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_position_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubPositionModelImpl _$$ClubPositionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ClubPositionModelImpl(
      id: json['_id'] as String?,
      clubID: json['clubID'] as String,
      position: json['position'] as String,
      lastLocalUpdate: json['lastLocalUpdate'] == null
          ? null
          : DateTime.parse(json['lastLocalUpdate'] as String),
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$PermissionsEnumMap, e))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ClubPositionModelImplToJson(
        _$ClubPositionModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'clubID': instance.clubID,
      'position': instance.position,
      'lastLocalUpdate': instance.lastLocalUpdate?.toIso8601String(),
      'permissions':
          instance.permissions.map((e) => _$PermissionsEnumMap[e]!).toList(),
    };

const _$PermissionsEnumMap = {
  Permissions.read: 'read',
  Permissions.modifyEvents: 'modifyEvents',
  Permissions.modifyMembers: 'modifyMembers',
  Permissions.modifyClub: 'modifyClub',
};
