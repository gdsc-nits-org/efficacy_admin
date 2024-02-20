// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppInfoModel _$AppInfoModelFromJson(Map<String, dynamic> json) {
  return _AppInfoModel.fromJson(json);
}

/// @nodoc
mixin _$AppInfoModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get contactEmail => throw _privateConstructorUsedError;
  List<String> get adminEmails => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppInfoModelCopyWith<AppInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppInfoModelCopyWith<$Res> {
  factory $AppInfoModelCopyWith(
          AppInfoModel value, $Res Function(AppInfoModel) then) =
      _$AppInfoModelCopyWithImpl<$Res, AppInfoModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String contactEmail,
      List<String> adminEmails});
}

/// @nodoc
class _$AppInfoModelCopyWithImpl<$Res, $Val extends AppInfoModel>
    implements $AppInfoModelCopyWith<$Res> {
  _$AppInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? contactEmail = null,
    Object? adminEmails = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      contactEmail: null == contactEmail
          ? _value.contactEmail
          : contactEmail // ignore: cast_nullable_to_non_nullable
              as String,
      adminEmails: null == adminEmails
          ? _value.adminEmails
          : adminEmails // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppInfoModelImplCopyWith<$Res>
    implements $AppInfoModelCopyWith<$Res> {
  factory _$$AppInfoModelImplCopyWith(
          _$AppInfoModelImpl value, $Res Function(_$AppInfoModelImpl) then) =
      __$$AppInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String contactEmail,
      List<String> adminEmails});
}

/// @nodoc
class __$$AppInfoModelImplCopyWithImpl<$Res>
    extends _$AppInfoModelCopyWithImpl<$Res, _$AppInfoModelImpl>
    implements _$$AppInfoModelImplCopyWith<$Res> {
  __$$AppInfoModelImplCopyWithImpl(
      _$AppInfoModelImpl _value, $Res Function(_$AppInfoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? contactEmail = null,
    Object? adminEmails = null,
  }) {
    return _then(_$AppInfoModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      contactEmail: null == contactEmail
          ? _value.contactEmail
          : contactEmail // ignore: cast_nullable_to_non_nullable
              as String,
      adminEmails: null == adminEmails
          ? _value._adminEmails
          : adminEmails // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppInfoModelImpl extends _AppInfoModel {
  const _$AppInfoModelImpl(
      {@JsonKey(name: '_id') this.id,
      required this.contactEmail,
      required final List<String> adminEmails})
      : _adminEmails = adminEmails,
        super._();

  factory _$AppInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppInfoModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String contactEmail;
  final List<String> _adminEmails;
  @override
  List<String> get adminEmails {
    if (_adminEmails is EqualUnmodifiableListView) return _adminEmails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_adminEmails);
  }

  @override
  String toString() {
    return 'AppInfoModel(id: $id, contactEmail: $contactEmail, adminEmails: $adminEmails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppInfoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.contactEmail, contactEmail) ||
                other.contactEmail == contactEmail) &&
            const DeepCollectionEquality()
                .equals(other._adminEmails, _adminEmails));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, contactEmail,
      const DeepCollectionEquality().hash(_adminEmails));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppInfoModelImplCopyWith<_$AppInfoModelImpl> get copyWith =>
      __$$AppInfoModelImplCopyWithImpl<_$AppInfoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppInfoModelImplToJson(
      this,
    );
  }
}

abstract class _AppInfoModel extends AppInfoModel {
  const factory _AppInfoModel(
      {@JsonKey(name: '_id') final String? id,
      required final String contactEmail,
      required final List<String> adminEmails}) = _$AppInfoModelImpl;
  const _AppInfoModel._() : super._();

  factory _AppInfoModel.fromJson(Map<String, dynamic> json) =
      _$AppInfoModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get contactEmail;
  @override
  List<String> get adminEmails;
  @override
  @JsonKey(ignore: true)
  _$$AppInfoModelImplCopyWith<_$AppInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
