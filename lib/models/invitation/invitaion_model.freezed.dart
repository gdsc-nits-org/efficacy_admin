// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitaion_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InvitationModel _$InvitationModelFromJson(Map<String, dynamic> json) {
  return _InvitationModel.fromJson(json);
}

/// @nodoc
mixin _$InvitationModel {
  @JsonKey(name: "_id")
  String? get id => throw _privateConstructorUsedError;
  String get clubPositionID => throw _privateConstructorUsedError;
  String get senderID => throw _privateConstructorUsedError;
  String get recipientID => throw _privateConstructorUsedError;
  DateTime? get expiry => throw _privateConstructorUsedError;
  DateTime? get lastLocalUpdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvitationModelCopyWith<InvitationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationModelCopyWith<$Res> {
  factory $InvitationModelCopyWith(
          InvitationModel value, $Res Function(InvitationModel) then) =
      _$InvitationModelCopyWithImpl<$Res, InvitationModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String? id,
      String clubPositionID,
      String senderID,
      String recipientID,
      DateTime? expiry,
      DateTime? lastLocalUpdate});
}

/// @nodoc
class _$InvitationModelCopyWithImpl<$Res, $Val extends InvitationModel>
    implements $InvitationModelCopyWith<$Res> {
  _$InvitationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? clubPositionID = null,
    Object? senderID = null,
    Object? recipientID = null,
    Object? expiry = freezed,
    Object? lastLocalUpdate = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      clubPositionID: null == clubPositionID
          ? _value.clubPositionID
          : clubPositionID // ignore: cast_nullable_to_non_nullable
              as String,
      senderID: null == senderID
          ? _value.senderID
          : senderID // ignore: cast_nullable_to_non_nullable
              as String,
      recipientID: null == recipientID
          ? _value.recipientID
          : recipientID // ignore: cast_nullable_to_non_nullable
              as String,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLocalUpdate: freezed == lastLocalUpdate
          ? _value.lastLocalUpdate
          : lastLocalUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvitationModelImplCopyWith<$Res>
    implements $InvitationModelCopyWith<$Res> {
  factory _$$InvitationModelImplCopyWith(_$InvitationModelImpl value,
          $Res Function(_$InvitationModelImpl) then) =
      __$$InvitationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String? id,
      String clubPositionID,
      String senderID,
      String recipientID,
      DateTime? expiry,
      DateTime? lastLocalUpdate});
}

/// @nodoc
class __$$InvitationModelImplCopyWithImpl<$Res>
    extends _$InvitationModelCopyWithImpl<$Res, _$InvitationModelImpl>
    implements _$$InvitationModelImplCopyWith<$Res> {
  __$$InvitationModelImplCopyWithImpl(
      _$InvitationModelImpl _value, $Res Function(_$InvitationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? clubPositionID = null,
    Object? senderID = null,
    Object? recipientID = null,
    Object? expiry = freezed,
    Object? lastLocalUpdate = freezed,
  }) {
    return _then(_$InvitationModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      clubPositionID: null == clubPositionID
          ? _value.clubPositionID
          : clubPositionID // ignore: cast_nullable_to_non_nullable
              as String,
      senderID: null == senderID
          ? _value.senderID
          : senderID // ignore: cast_nullable_to_non_nullable
              as String,
      recipientID: null == recipientID
          ? _value.recipientID
          : recipientID // ignore: cast_nullable_to_non_nullable
              as String,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLocalUpdate: freezed == lastLocalUpdate
          ? _value.lastLocalUpdate
          : lastLocalUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvitationModelImpl extends _InvitationModel {
  const _$InvitationModelImpl(
      {@JsonKey(name: "_id") this.id,
      required this.clubPositionID,
      required this.senderID,
      required this.recipientID,
      this.expiry,
      this.lastLocalUpdate})
      : super._();

  factory _$InvitationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvitationModelImplFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String? id;
  @override
  final String clubPositionID;
  @override
  final String senderID;
  @override
  final String recipientID;
  @override
  final DateTime? expiry;
  @override
  final DateTime? lastLocalUpdate;

  @override
  String toString() {
    return 'InvitationModel(id: $id, clubPositionID: $clubPositionID, senderID: $senderID, recipientID: $recipientID, expiry: $expiry, lastLocalUpdate: $lastLocalUpdate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clubPositionID, clubPositionID) ||
                other.clubPositionID == clubPositionID) &&
            (identical(other.senderID, senderID) ||
                other.senderID == senderID) &&
            (identical(other.recipientID, recipientID) ||
                other.recipientID == recipientID) &&
            (identical(other.expiry, expiry) || other.expiry == expiry) &&
            (identical(other.lastLocalUpdate, lastLocalUpdate) ||
                other.lastLocalUpdate == lastLocalUpdate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, clubPositionID, senderID,
      recipientID, expiry, lastLocalUpdate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationModelImplCopyWith<_$InvitationModelImpl> get copyWith =>
      __$$InvitationModelImplCopyWithImpl<_$InvitationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvitationModelImplToJson(
      this,
    );
  }
}

abstract class _InvitationModel extends InvitationModel {
  const factory _InvitationModel(
      {@JsonKey(name: "_id") final String? id,
      required final String clubPositionID,
      required final String senderID,
      required final String recipientID,
      final DateTime? expiry,
      final DateTime? lastLocalUpdate}) = _$InvitationModelImpl;
  const _InvitationModel._() : super._();

  factory _InvitationModel.fromJson(Map<String, dynamic> json) =
      _$InvitationModelImpl.fromJson;

  @override
  @JsonKey(name: "_id")
  String? get id;
  @override
  String get clubPositionID;
  @override
  String get senderID;
  @override
  String get recipientID;
  @override
  DateTime? get expiry;
  @override
  DateTime? get lastLocalUpdate;
  @override
  @JsonKey(ignore: true)
  _$$InvitationModelImplCopyWith<_$InvitationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
