// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification_code_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerificationCodeModel _$VerificationCodeModelFromJson(
    Map<String, dynamic> json) {
  return _VerificationCodeModel.fromJson(json);
}

/// @nodoc
mixin _$VerificationCodeModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// Which app does this user instance belong to
  /// No need to touch this
  String get app => throw _privateConstructorUsedError;
  DateTime? get lastLocalUpdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerificationCodeModelCopyWith<VerificationCodeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationCodeModelCopyWith<$Res> {
  factory $VerificationCodeModelCopyWith(VerificationCodeModel value,
          $Res Function(VerificationCodeModel) then) =
      _$VerificationCodeModelCopyWithImpl<$Res, VerificationCodeModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String email,
      String code,
      DateTime expiresAt,
      String app,
      DateTime? lastLocalUpdate});
}

/// @nodoc
class _$VerificationCodeModelCopyWithImpl<$Res,
        $Val extends VerificationCodeModel>
    implements $VerificationCodeModelCopyWith<$Res> {
  _$VerificationCodeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = null,
    Object? code = null,
    Object? expiresAt = null,
    Object? app = null,
    Object? lastLocalUpdate = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      app: null == app
          ? _value.app
          : app // ignore: cast_nullable_to_non_nullable
              as String,
      lastLocalUpdate: freezed == lastLocalUpdate
          ? _value.lastLocalUpdate
          : lastLocalUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerificationCodeModelImplCopyWith<$Res>
    implements $VerificationCodeModelCopyWith<$Res> {
  factory _$$VerificationCodeModelImplCopyWith(
          _$VerificationCodeModelImpl value,
          $Res Function(_$VerificationCodeModelImpl) then) =
      __$$VerificationCodeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String email,
      String code,
      DateTime expiresAt,
      String app,
      DateTime? lastLocalUpdate});
}

/// @nodoc
class __$$VerificationCodeModelImplCopyWithImpl<$Res>
    extends _$VerificationCodeModelCopyWithImpl<$Res,
        _$VerificationCodeModelImpl>
    implements _$$VerificationCodeModelImplCopyWith<$Res> {
  __$$VerificationCodeModelImplCopyWithImpl(_$VerificationCodeModelImpl _value,
      $Res Function(_$VerificationCodeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = null,
    Object? code = null,
    Object? expiresAt = null,
    Object? app = null,
    Object? lastLocalUpdate = freezed,
  }) {
    return _then(_$VerificationCodeModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      app: null == app
          ? _value.app
          : app // ignore: cast_nullable_to_non_nullable
              as String,
      lastLocalUpdate: freezed == lastLocalUpdate
          ? _value.lastLocalUpdate
          : lastLocalUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerificationCodeModelImpl extends _VerificationCodeModel {
  const _$VerificationCodeModelImpl(
      {@JsonKey(name: '_id') this.id,
      required this.email,
      required this.code,
      required this.expiresAt,
      this.app = appName,
      this.lastLocalUpdate})
      : super._();

  factory _$VerificationCodeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerificationCodeModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String email;
  @override
  final String code;
  @override
  final DateTime expiresAt;

  /// Which app does this user instance belong to
  /// No need to touch this
  @override
  @JsonKey()
  final String app;
  @override
  final DateTime? lastLocalUpdate;

  @override
  String toString() {
    return 'VerificationCodeModel(id: $id, email: $email, code: $code, expiresAt: $expiresAt, app: $app, lastLocalUpdate: $lastLocalUpdate)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerificationCodeModelImplCopyWith<_$VerificationCodeModelImpl>
      get copyWith => __$$VerificationCodeModelImplCopyWithImpl<
          _$VerificationCodeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerificationCodeModelImplToJson(
      this,
    );
  }
}

abstract class _VerificationCodeModel extends VerificationCodeModel {
  const factory _VerificationCodeModel(
      {@JsonKey(name: '_id') final String? id,
      required final String email,
      required final String code,
      required final DateTime expiresAt,
      final String app,
      final DateTime? lastLocalUpdate}) = _$VerificationCodeModelImpl;
  const _VerificationCodeModel._() : super._();

  factory _VerificationCodeModel.fromJson(Map<String, dynamic> json) =
      _$VerificationCodeModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get email;
  @override
  String get code;
  @override
  DateTime get expiresAt;
  @override

  /// Which app does this user instance belong to
  /// No need to touch this
  String get app;
  @override
  DateTime? get lastLocalUpdate;
  @override
  @JsonKey(ignore: true)
  _$$VerificationCodeModelImplCopyWith<_$VerificationCodeModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
