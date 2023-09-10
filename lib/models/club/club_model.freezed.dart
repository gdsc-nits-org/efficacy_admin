// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClubModel _$ClubModelFromJson(Map<String, dynamic> json) {
  return _ClubModel.fromJson(json);
}

/// @nodoc
mixin _$ClubModel {
  String get description => throw _privateConstructorUsedError;
  Map<Social, String> get socials => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @PhoneNumberSerializer()
  PhoneNumber? get phoneNumber => throw _privateConstructorUsedError;
  String get clubLogoURL => throw _privateConstructorUsedError;
  String? get clubBannerURL => throw _privateConstructorUsedError;

  /// Map<Position, Member ID>
  Map<String, String> get members => throw _privateConstructorUsedError;

  /// Follower Ids
  List<String> get followers => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubModelCopyWith<ClubModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubModelCopyWith<$Res> {
  factory $ClubModelCopyWith(ClubModel value, $Res Function(ClubModel) then) =
      _$ClubModelCopyWithImpl<$Res, ClubModel>;
  @useResult
  $Res call(
      {String description,
      Map<Social, String> socials,
      String email,
      @PhoneNumberSerializer() PhoneNumber? phoneNumber,
      String clubLogoURL,
      String? clubBannerURL,
      Map<String, String> members,
      List<String> followers});
}

/// @nodoc
class _$ClubModelCopyWithImpl<$Res, $Val extends ClubModel>
    implements $ClubModelCopyWith<$Res> {
  _$ClubModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? socials = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? clubLogoURL = null,
    Object? clubBannerURL = freezed,
    Object? members = null,
    Object? followers = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      socials: null == socials
          ? _value.socials
          : socials // ignore: cast_nullable_to_non_nullable
              as Map<Social, String>,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber?,
      clubLogoURL: null == clubLogoURL
          ? _value.clubLogoURL
          : clubLogoURL // ignore: cast_nullable_to_non_nullable
              as String,
      clubBannerURL: freezed == clubBannerURL
          ? _value.clubBannerURL
          : clubBannerURL // ignore: cast_nullable_to_non_nullable
              as String?,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      followers: null == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClubModelCopyWith<$Res> implements $ClubModelCopyWith<$Res> {
  factory _$$_ClubModelCopyWith(
          _$_ClubModel value, $Res Function(_$_ClubModel) then) =
      __$$_ClubModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String description,
      Map<Social, String> socials,
      String email,
      @PhoneNumberSerializer() PhoneNumber? phoneNumber,
      String clubLogoURL,
      String? clubBannerURL,
      Map<String, String> members,
      List<String> followers});
}

/// @nodoc
class __$$_ClubModelCopyWithImpl<$Res>
    extends _$ClubModelCopyWithImpl<$Res, _$_ClubModel>
    implements _$$_ClubModelCopyWith<$Res> {
  __$$_ClubModelCopyWithImpl(
      _$_ClubModel _value, $Res Function(_$_ClubModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? socials = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? clubLogoURL = null,
    Object? clubBannerURL = freezed,
    Object? members = null,
    Object? followers = null,
  }) {
    return _then(_$_ClubModel(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      socials: null == socials
          ? _value._socials
          : socials // ignore: cast_nullable_to_non_nullable
              as Map<Social, String>,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber?,
      clubLogoURL: null == clubLogoURL
          ? _value.clubLogoURL
          : clubLogoURL // ignore: cast_nullable_to_non_nullable
              as String,
      clubBannerURL: freezed == clubBannerURL
          ? _value.clubBannerURL
          : clubBannerURL // ignore: cast_nullable_to_non_nullable
              as String?,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      followers: null == followers
          ? _value._followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClubModel implements _ClubModel {
  const _$_ClubModel(
      {required this.description,
      final Map<Social, String> socials = const {},
      required this.email,
      @PhoneNumberSerializer() this.phoneNumber,
      required this.clubLogoURL,
      this.clubBannerURL,
      required final Map<String, String> members,
      final List<String> followers = const []})
      : _socials = socials,
        _members = members,
        _followers = followers;

  factory _$_ClubModel.fromJson(Map<String, dynamic> json) =>
      _$$_ClubModelFromJson(json);

  @override
  final String description;
  final Map<Social, String> _socials;
  @override
  @JsonKey()
  Map<Social, String> get socials {
    if (_socials is EqualUnmodifiableMapView) return _socials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_socials);
  }

  @override
  final String email;
  @override
  @PhoneNumberSerializer()
  final PhoneNumber? phoneNumber;
  @override
  final String clubLogoURL;
  @override
  final String? clubBannerURL;

  /// Map<Position, Member ID>
  final Map<String, String> _members;

  /// Map<Position, Member ID>
  @override
  Map<String, String> get members {
    if (_members is EqualUnmodifiableMapView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_members);
  }

  /// Follower Ids
  final List<String> _followers;

  /// Follower Ids
  @override
  @JsonKey()
  List<String> get followers {
    if (_followers is EqualUnmodifiableListView) return _followers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_followers);
  }

  @override
  String toString() {
    return 'ClubModel(description: $description, socials: $socials, email: $email, phoneNumber: $phoneNumber, clubLogoURL: $clubLogoURL, clubBannerURL: $clubBannerURL, members: $members, followers: $followers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClubModel &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._socials, _socials) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.clubLogoURL, clubLogoURL) ||
                other.clubLogoURL == clubLogoURL) &&
            (identical(other.clubBannerURL, clubBannerURL) ||
                other.clubBannerURL == clubBannerURL) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            const DeepCollectionEquality()
                .equals(other._followers, _followers));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      description,
      const DeepCollectionEquality().hash(_socials),
      email,
      phoneNumber,
      clubLogoURL,
      clubBannerURL,
      const DeepCollectionEquality().hash(_members),
      const DeepCollectionEquality().hash(_followers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClubModelCopyWith<_$_ClubModel> get copyWith =>
      __$$_ClubModelCopyWithImpl<_$_ClubModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClubModelToJson(
      this,
    );
  }
}

abstract class _ClubModel implements ClubModel {
  const factory _ClubModel(
      {required final String description,
      final Map<Social, String> socials,
      required final String email,
      @PhoneNumberSerializer() final PhoneNumber? phoneNumber,
      required final String clubLogoURL,
      final String? clubBannerURL,
      required final Map<String, String> members,
      final List<String> followers}) = _$_ClubModel;

  factory _ClubModel.fromJson(Map<String, dynamic> json) =
      _$_ClubModel.fromJson;

  @override
  String get description;
  @override
  Map<Social, String> get socials;
  @override
  String get email;
  @override
  @PhoneNumberSerializer()
  PhoneNumber? get phoneNumber;
  @override
  String get clubLogoURL;
  @override
  String? get clubBannerURL;
  @override

  /// Map<Position, Member ID>
  Map<String, String> get members;
  @override

  /// Follower Ids
  List<String> get followers;
  @override
  @JsonKey(ignore: true)
  _$$_ClubModelCopyWith<_$_ClubModel> get copyWith =>
      throw _privateConstructorUsedError;
}
