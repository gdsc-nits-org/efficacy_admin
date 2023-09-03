// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get name => throw _privateConstructorUsedError;
  @PhoneNumberSerializer()
  PhoneNumber? get phoneNumber => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get scholarID => throw _privateConstructorUsedError;
  String? get userPhoto => throw _privateConstructorUsedError;
  Branch get branch => throw _privateConstructorUsedError;
  Degree get degree => throw _privateConstructorUsedError;
  Map<Social, String> get socials => throw _privateConstructorUsedError;
  List<ClubPosition> get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String name,
      @PhoneNumberSerializer() PhoneNumber? phoneNumber,
      String email,
      String scholarID,
      String? userPhoto,
      Branch branch,
      Degree degree,
      Map<Social, String> socials,
      List<ClubPosition> position});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? phoneNumber = freezed,
    Object? email = null,
    Object? scholarID = null,
    Object? userPhoto = freezed,
    Object? branch = null,
    Object? degree = null,
    Object? socials = null,
    Object? position = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber?,
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
              as List<ClubPosition>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      @PhoneNumberSerializer() PhoneNumber? phoneNumber,
      String email,
      String scholarID,
      String? userPhoto,
      Branch branch,
      Degree degree,
      Map<Social, String> socials,
      List<ClubPosition> position});
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$_User>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? phoneNumber = freezed,
    Object? email = null,
    Object? scholarID = null,
    Object? userPhoto = freezed,
    Object? branch = null,
    Object? degree = null,
    Object? socials = null,
    Object? position = null,
  }) {
    return _then(_$_User(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber?,
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
              as List<ClubPosition>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User implements _User {
  const _$_User(
      {required this.name,
      @PhoneNumberSerializer() this.phoneNumber,
      required this.email,
      required this.scholarID,
      this.userPhoto,
      required this.branch,
      required this.degree,
      final Map<Social, String> socials = const {},
      final List<ClubPosition> position = const []})
      : _socials = socials,
        _position = position;

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  final String name;
  @override
  @PhoneNumberSerializer()
  final PhoneNumber? phoneNumber;
  @override
  final String email;
  @override
  final String scholarID;
  @override
  final String? userPhoto;
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

  final List<ClubPosition> _position;
  @override
  @JsonKey()
  List<ClubPosition> get position {
    if (_position is EqualUnmodifiableListView) return _position;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_position);
  }

  @override
  String toString() {
    return 'User(name: $name, phoneNumber: $phoneNumber, email: $email, scholarID: $scholarID, userPhoto: $userPhoto, branch: $branch, degree: $degree, socials: $socials, position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.scholarID, scholarID) ||
                other.scholarID == scholarID) &&
            (identical(other.userPhoto, userPhoto) ||
                other.userPhoto == userPhoto) &&
            (identical(other.branch, branch) || other.branch == branch) &&
            (identical(other.degree, degree) || other.degree == degree) &&
            const DeepCollectionEquality().equals(other._socials, _socials) &&
            const DeepCollectionEquality().equals(other._position, _position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      phoneNumber,
      email,
      scholarID,
      userPhoto,
      branch,
      degree,
      const DeepCollectionEquality().hash(_socials),
      const DeepCollectionEquality().hash(_position));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final String name,
      @PhoneNumberSerializer() final PhoneNumber? phoneNumber,
      required final String email,
      required final String scholarID,
      final String? userPhoto,
      required final Branch branch,
      required final Degree degree,
      final Map<Social, String> socials,
      final List<ClubPosition> position}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String get name;
  @override
  @PhoneNumberSerializer()
  PhoneNumber? get phoneNumber;
  @override
  String get email;
  @override
  String get scholarID;
  @override
  String? get userPhoto;
  @override
  Branch get branch;
  @override
  Degree get degree;
  @override
  Map<Social, String> get socials;
  @override
  List<ClubPosition> get position;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
