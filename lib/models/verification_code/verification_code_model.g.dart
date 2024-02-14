// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerificationCodeModelImpl _$$VerificationCodeModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VerificationCodeModelImpl(
      id: json['_id'] as String?,
      email: json['email'] as String,
      code: json['code'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      app: json['app'] as String? ?? appName,
      lastLocalUpdate: json['lastLocalUpdate'] == null
          ? null
          : DateTime.parse(json['lastLocalUpdate'] as String),
    );

Map<String, dynamic> _$$VerificationCodeModelImplToJson(
        _$VerificationCodeModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'code': instance.code,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'app': instance.app,
      'lastLocalUpdate': instance.lastLocalUpdate?.toIso8601String(),
    };
