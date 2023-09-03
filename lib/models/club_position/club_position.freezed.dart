// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClubPosition _$ClubPositionFromJson(Map<String, dynamic> json) {
  return _ClubPosition.fromJson(json);
}

/// @nodoc
mixin _$ClubPosition {
  String get clubID => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubPositionCopyWith<ClubPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubPositionCopyWith<$Res> {
  factory $ClubPositionCopyWith(
          ClubPosition value, $Res Function(ClubPosition) then) =
      _$ClubPositionCopyWithImpl<$Res, ClubPosition>;
  @useResult
  $Res call({String clubID, String position});
}

/// @nodoc
class _$ClubPositionCopyWithImpl<$Res, $Val extends ClubPosition>
    implements $ClubPositionCopyWith<$Res> {
  _$ClubPositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubID = null,
    Object? position = null,
  }) {
    return _then(_value.copyWith(
      clubID: null == clubID
          ? _value.clubID
          : clubID // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClubPositionCopyWith<$Res>
    implements $ClubPositionCopyWith<$Res> {
  factory _$$_ClubPositionCopyWith(
          _$_ClubPosition value, $Res Function(_$_ClubPosition) then) =
      __$$_ClubPositionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String clubID, String position});
}

/// @nodoc
class __$$_ClubPositionCopyWithImpl<$Res>
    extends _$ClubPositionCopyWithImpl<$Res, _$_ClubPosition>
    implements _$$_ClubPositionCopyWith<$Res> {
  __$$_ClubPositionCopyWithImpl(
      _$_ClubPosition _value, $Res Function(_$_ClubPosition) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clubID = null,
    Object? position = null,
  }) {
    return _then(_$_ClubPosition(
      clubID: null == clubID
          ? _value.clubID
          : clubID // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClubPosition implements _ClubPosition {
  const _$_ClubPosition({required this.clubID, required this.position});

  factory _$_ClubPosition.fromJson(Map<String, dynamic> json) =>
      _$$_ClubPositionFromJson(json);

  @override
  final String clubID;
  @override
  final String position;

  @override
  String toString() {
    return 'ClubPosition(clubID: $clubID, position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClubPosition &&
            (identical(other.clubID, clubID) || other.clubID == clubID) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, clubID, position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClubPositionCopyWith<_$_ClubPosition> get copyWith =>
      __$$_ClubPositionCopyWithImpl<_$_ClubPosition>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClubPositionToJson(
      this,
    );
  }
}

abstract class _ClubPosition implements ClubPosition {
  const factory _ClubPosition(
      {required final String clubID,
      required final String position}) = _$_ClubPosition;

  factory _ClubPosition.fromJson(Map<String, dynamic> json) =
      _$_ClubPosition.fromJson;

  @override
  String get clubID;
  @override
  String get position;
  @override
  @JsonKey(ignore: true)
  _$$_ClubPositionCopyWith<_$_ClubPosition> get copyWith =>
      throw _privateConstructorUsedError;
}
