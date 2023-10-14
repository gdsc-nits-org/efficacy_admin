// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_position_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClubPositionModel _$ClubPositionModelFromJson(Map<String, dynamic> json) {
  return _ClubPositionModel.fromJson(json);
}

/// @nodoc
mixin _$ClubPositionModel {
  @JsonKey(name: '_id')
  @ObjectIdSerializer()
  ObjectId? get id => throw _privateConstructorUsedError;
  String get clubID => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;
  DateTime? get lastLocalUpdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubPositionModelCopyWith<ClubPositionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubPositionModelCopyWith<$Res> {
  factory $ClubPositionModelCopyWith(
          ClubPositionModel value, $Res Function(ClubPositionModel) then) =
      _$ClubPositionModelCopyWithImpl<$Res, ClubPositionModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') @ObjectIdSerializer() ObjectId? id,
      String clubID,
      String position,
      DateTime? lastLocalUpdate});
}

/// @nodoc
class _$ClubPositionModelCopyWithImpl<$Res, $Val extends ClubPositionModel>
    implements $ClubPositionModelCopyWith<$Res> {
  _$ClubPositionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? clubID = null,
    Object? position = null,
    Object? lastLocalUpdate = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as ObjectId?,
      clubID: null == clubID
          ? _value.clubID
          : clubID // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      lastLocalUpdate: freezed == lastLocalUpdate
          ? _value.lastLocalUpdate
          : lastLocalUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClubPositionModelCopyWith<$Res>
    implements $ClubPositionModelCopyWith<$Res> {
  factory _$$_ClubPositionModelCopyWith(_$_ClubPositionModel value,
          $Res Function(_$_ClubPositionModel) then) =
      __$$_ClubPositionModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') @ObjectIdSerializer() ObjectId? id,
      String clubID,
      String position,
      DateTime? lastLocalUpdate});
}

/// @nodoc
class __$$_ClubPositionModelCopyWithImpl<$Res>
    extends _$ClubPositionModelCopyWithImpl<$Res, _$_ClubPositionModel>
    implements _$$_ClubPositionModelCopyWith<$Res> {
  __$$_ClubPositionModelCopyWithImpl(
      _$_ClubPositionModel _value, $Res Function(_$_ClubPositionModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? clubID = null,
    Object? position = null,
    Object? lastLocalUpdate = freezed,
  }) {
    return _then(_$_ClubPositionModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as ObjectId?,
      clubID: null == clubID
          ? _value.clubID
          : clubID // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
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
class _$_ClubPositionModel implements _ClubPositionModel {
  const _$_ClubPositionModel(
      {@JsonKey(name: '_id') @ObjectIdSerializer() this.id,
      required this.clubID,
      required this.position,
      this.lastLocalUpdate});

  factory _$_ClubPositionModel.fromJson(Map<String, dynamic> json) =>
      _$$_ClubPositionModelFromJson(json);

  @override
  @JsonKey(name: '_id')
  @ObjectIdSerializer()
  final ObjectId? id;
  @override
  final String clubID;
  @override
  final String position;
  @override
  final DateTime? lastLocalUpdate;

  @override
  String toString() {
    return 'ClubPositionModel(id: $id, clubID: $clubID, position: $position, lastLocalUpdate: $lastLocalUpdate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClubPositionModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clubID, clubID) || other.clubID == clubID) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.lastLocalUpdate, lastLocalUpdate) ||
                other.lastLocalUpdate == lastLocalUpdate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, clubID, position, lastLocalUpdate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClubPositionModelCopyWith<_$_ClubPositionModel> get copyWith =>
      __$$_ClubPositionModelCopyWithImpl<_$_ClubPositionModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClubPositionModelToJson(
      this,
    );
  }
}

abstract class _ClubPositionModel implements ClubPositionModel {
  const factory _ClubPositionModel(
      {@JsonKey(name: '_id') @ObjectIdSerializer() final ObjectId? id,
      required final String clubID,
      required final String position,
      final DateTime? lastLocalUpdate}) = _$_ClubPositionModel;

  factory _ClubPositionModel.fromJson(Map<String, dynamic> json) =
      _$_ClubPositionModel.fromJson;

  @override
  @JsonKey(name: '_id')
  @ObjectIdSerializer()
  ObjectId? get id;
  @override
  String get clubID;
  @override
  String get position;
  @override
  DateTime? get lastLocalUpdate;
  @override
  @JsonKey(ignore: true)
  _$$_ClubPositionModelCopyWith<_$_ClubPositionModel> get copyWith =>
      throw _privateConstructorUsedError;
}
