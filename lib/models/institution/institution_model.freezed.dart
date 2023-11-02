// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'institution_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InstitutionModel _$InstitutionModelFromJson(Map<String, dynamic> json) {
  return _InstitutionModel.fromJson(json);
}

/// @nodoc
mixin _$InstitutionModel {
  @JsonKey(name: "_id")
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime? get lastLocalUpdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InstitutionModelCopyWith<InstitutionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InstitutionModelCopyWith<$Res> {
  factory $InstitutionModelCopyWith(
          InstitutionModel value, $Res Function(InstitutionModel) then) =
      _$InstitutionModelCopyWithImpl<$Res, InstitutionModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String? id,
      String name,
      DateTime? lastLocalUpdate});
}

/// @nodoc
class _$InstitutionModelCopyWithImpl<$Res, $Val extends InstitutionModel>
    implements $InstitutionModelCopyWith<$Res> {
  _$InstitutionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? lastLocalUpdate = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lastLocalUpdate: freezed == lastLocalUpdate
          ? _value.lastLocalUpdate
          : lastLocalUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InstitutionModelImplCopyWith<$Res>
    implements $InstitutionModelCopyWith<$Res> {
  factory _$$InstitutionModelImplCopyWith(_$InstitutionModelImpl value,
          $Res Function(_$InstitutionModelImpl) then) =
      __$$InstitutionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String? id,
      String name,
      DateTime? lastLocalUpdate});
}

/// @nodoc
class __$$InstitutionModelImplCopyWithImpl<$Res>
    extends _$InstitutionModelCopyWithImpl<$Res, _$InstitutionModelImpl>
    implements _$$InstitutionModelImplCopyWith<$Res> {
  __$$InstitutionModelImplCopyWithImpl(_$InstitutionModelImpl _value,
      $Res Function(_$InstitutionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? lastLocalUpdate = freezed,
  }) {
    return _then(_$InstitutionModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
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
class _$InstitutionModelImpl extends _InstitutionModel {
  const _$InstitutionModelImpl(
      {@JsonKey(name: "_id") this.id, required this.name, this.lastLocalUpdate})
      : super._();

  factory _$InstitutionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InstitutionModelImplFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String? id;
  @override
  final String name;
  @override
  final DateTime? lastLocalUpdate;

  @override
  String toString() {
    return 'InstitutionModel(id: $id, name: $name, lastLocalUpdate: $lastLocalUpdate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InstitutionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lastLocalUpdate, lastLocalUpdate) ||
                other.lastLocalUpdate == lastLocalUpdate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, lastLocalUpdate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InstitutionModelImplCopyWith<_$InstitutionModelImpl> get copyWith =>
      __$$InstitutionModelImplCopyWithImpl<_$InstitutionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InstitutionModelImplToJson(
      this,
    );
  }
}

abstract class _InstitutionModel extends InstitutionModel {
  const factory _InstitutionModel(
      {@JsonKey(name: "_id") final String? id,
      required final String name,
      final DateTime? lastLocalUpdate}) = _$InstitutionModelImpl;
  const _InstitutionModel._() : super._();

  factory _InstitutionModel.fromJson(Map<String, dynamic> json) =
      _$InstitutionModelImpl.fromJson;

  @override
  @JsonKey(name: "_id")
  String? get id;
  @override
  String get name;
  @override
  DateTime? get lastLocalUpdate;
  @override
  @JsonKey(ignore: true)
  _$$InstitutionModelImplCopyWith<_$InstitutionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
