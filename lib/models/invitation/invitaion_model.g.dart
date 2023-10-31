// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitaion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvitationModelImpl _$$InvitationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$InvitationModelImpl(
      id: json['_id'] as String?,
      clubPositionID: json['clubPositionID'] as String,
      senderID: json['senderID'] as String,
      recipientID: json['recipientID'] as String,
      expiry: json['expiry'] == null
          ? null
          : DateTime.parse(json['expiry'] as String),
      lastLocalUpdate: json['lastLocalUpdate'] == null
          ? null
          : DateTime.parse(json['lastLocalUpdate'] as String),
    );

Map<String, dynamic> _$$InvitationModelImplToJson(
        _$InvitationModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'clubPositionID': instance.clubPositionID,
      'senderID': instance.senderID,
      'recipientID': instance.recipientID,
      'expiry': instance.expiry?.toIso8601String(),
      'lastLocalUpdate': instance.lastLocalUpdate?.toIso8601String(),
    };
