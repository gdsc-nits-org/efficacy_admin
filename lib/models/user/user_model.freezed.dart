// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @PhoneNumberSerializer()
  PhoneNumber? get phoneNumber => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get scholarID => throw _privateConstructorUsedError;
  String? get userPhoto => throw _privateConstructorUsedError;
  String? get userPhotoPublicID => throw _privateConstructorUsedError;
  Branch get branch => throw _privateConstructorUsedError;
  Degree get degree => throw _privateConstructorUsedError;
  Map<Social, String> get socials => throw _privateConstructorUsedError;

  /// List<ClubPositionID>
  List<String> get position => throw _privateConstructorUsedError;
  DateTime? get lastLocalUpdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String name,
      @PhoneNumberSerializer() PhoneNumber? phoneNumber,
      String? password,
      String email,
      String scholarID,
      String? userPhoto,
      String? userPhotoPublicID,
      Branch branch,
      Degree degree,
      Map<Social, String> socials,
      List<String> position,
      DateTime? lastLocalUpdate});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? phoneNumber = freezed,
    Object? password = freezed,
    Object? email = null,
    Object? scholarID = null,
    Object? userPhoto = freezed,
    Object? userPhotoPublicID = freezed,
    Object? branch = null,
    Object? degree = null,
    Object? socials = null,
    Object? position = null,
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
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      scholarID: null == scholarID
          ? _value.scholarID
          : scholarID // ignore: cast_nullable_to_non_nullable
              as String,
      userPhoto: freezed == userPhoto
          ? _value.userPhoto
          : userPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      userPhotoPublicID: freezed == userPhotoPublicID
          ? _value.userPhotoPublicID
          : userPhotoPublicID // ignore: cast_nullable_to_non_nullable
              as String?,
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as Branch,
      degree: null == degree
          ? _value.degree
          : degree // ignore: cast_nullable_to_non_nullable
              as Degree,
      socials: null == socials
          ? _value.socials
          : socials // ignore: cast_nullable_to_non_nullable
              as Map<Social, String>,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastLocalUpdate: freezed == lastLocalUpdate
          ? _value.lastLocalUpdate
          : lastLocalUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String name,
      @PhoneNumberSerializer() PhoneNumber? phoneNumber,
      String? password,
      String email,
      String scholarID,
      String? userPhoto,
      String? userPhotoPublicID,
      Branch branch,
      Degree degree,
      Map<Social, String> socials,
      List<String> position,
      DateTime? lastLocalUpdate});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? phoneNumber = freezed,
    Object? password = freezed,
    Object? email = null,
    Object? scholarID = null,
    Object? userPhoto = freezed,
    Object? userPhotoPublicID = freezed,
    Object? branch = null,
    Object? degree = null,
    Object? socials = null,
    Object? position = null,
    Object? lastLocalUpdate = freezed,
  }) {
    return _then(_$UserModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      scholarID: null == scholarID
          ? _value.scholarID
          : scholarID // ignore: cast_nullable_to_non_nullable
              as String,
      userPhoto: freezed == userPhoto
          ? _value.userPhoto
          : userPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      userPhotoPublicID: freezed == userPhotoPublicID
          ? _value.userPhotoPublicID
          : userPhotoPublicID // ignore: cast_nullable_to_non_nullable
              as String?,
      branch: null == branch
          ? _value.branch
          : branch // ignore: cast_nullable_to_non_nullable
              as Branch,
      degree: null == degree
          ? _value.degree
          : degree // ignore: cast_nullable_to_non_nullable
              as Degree,
      socials: null == socials
          ? _value._socials
          : socials // ignore: cast_nullable_to_non_nullable
              as Map<Social, String>,
      position: null == position
          ? _value._position
          : position // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastLocalUpdate: freezed == lastLocalUpdate
          ? _value.lastLocalUpdate
          : lastLocalUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {@JsonKey(name: '_id') this.id,
      required this.name,
      @PhoneNumberSerializer() this.phoneNumber,
      this.password,
      required this.email,
      required this.scholarID,
      this.userPhoto,
      this.userPhotoPublicID,
      required this.branch,
      required this.degree,
      final Map<Social, String> socials = const {},
      final List<String> position = const [],
      this.lastLocalUpdate})
      : _socials = socials,
        _position = position;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String name;
  @override
  @PhoneNumberSerializer()
  final PhoneNumber? phoneNumber;
  @override
  final String? password;
  @override
  final String email;
  @override
  final String scholarID;
  @override
  final String? userPhoto;
  @override
  final String? userPhotoPublicID;
  @override
  final Branch branch;
  @override
  final Degree degree;
  final Map<Social, String> _socials;
  @override
  @JsonKey()
  Map<Social, String> get socials {
    if (_socials is EqualUnmodifiableMapView) return _socials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_socials);
  }

  /// List<ClubPositionID>
  final List<String> _position;

  /// List<ClubPositionID>
  @override
  @JsonKey()
  List<String> get position {
    if (_position is EqualUnmodifiableListView) return _position;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_position);
  }

  @override
  final DateTime? lastLocalUpdate;

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, phoneNumber: $phoneNumber, password: $password, email: $email, scholarID: $scholarID, userPhoto: $userPhoto, userPhotoPublicID: $userPhotoPublicID, branch: $branch, degree: $degree, socials: $socials, position: $position, lastLocalUpdate: $lastLocalUpdate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.scholarID, scholarID) ||
                other.scholarID == scholarID) &&
            (identical(other.userPhoto, userPhoto) ||
                other.userPhoto == userPhoto) &&
            (identical(other.userPhotoPublicID, userPhotoPublicID) ||
                other.userPhotoPublicID == userPhotoPublicID) &&
            (identical(other.branch, branch) || other.branch == branch) &&
            (identical(other.degree, degree) || other.degree == degree) &&
            const DeepCollectionEquality().equals(other._socials, _socials) &&
            const DeepCollectionEquality().equals(other._position, _position) &&
            (identical(other.lastLocalUpdate, lastLocalUpdate) ||
                other.lastLocalUpdate == lastLocalUpdate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      phoneNumber,
      password,
      email,
      scholarID,
      userPhoto,
      userPhotoPublicID,
      branch,
      degree,
      const DeepCollectionEquality().hash(_socials),
      const DeepCollectionEquality().hash(_position),
      lastLocalUpdate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {@JsonKey(name: '_id') final String? id,
      required final String name,
      @PhoneNumberSerializer() final PhoneNumber? phoneNumber,
      final String? password,
      required final String email,
      required final String scholarID,
      final String? userPhoto,
      final String? userPhotoPublicID,
      required final Branch branch,
      required final Degree degree,
      final Map<Social, String> socials,
      final List<String> position,
      final DateTime? lastLocalUpdate}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get name;
  @override
  @PhoneNumberSerializer()
  PhoneNumber? get phoneNumber;
  @override
  String? get password;
  @override
  String get email;
  @override
  String get scholarID;
  @override
  String? get userPhoto;
  @override
  String? get userPhotoPublicID;
  @override
  Branch get branch;
  @override
  Degree get degree;
  @override
  Map<Social, String> get socials;
  @override

  /// List<ClubPositionID>
  List<String> get position;
  @override
  DateTime? get lastLocalUpdate;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
