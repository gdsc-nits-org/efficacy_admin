// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitaion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InvitationModel _$$_InvitationModelFromJson(Map<String, dynamic> json) =>
    _$_InvitationModel(
      id: json['_id'] as String?,
      clubPositionID: json['clubPositionID'] as String,
      senderID: json['senderID'] as String,
      recipientID: json['recipientID'] as String,
      expiry: DateTime.parse(json['expiry'] as String),
    );

Map<String, dynamic> _$$_InvitationModelToJson(_$_InvitationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'clubPositionID': instance.clubPositionID,
      'senderID': instance.senderID,
      'recipientID': instance.recipientID,
      'expiry': instance.expiry.toIso8601String(),
    };
