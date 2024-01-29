// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EventModel _$EventModelFromJson(Map<String, dynamic> json) {
  return _EventModel.fromJson(json);
}

/// @nodoc
mixin _$EventModel {
  @JsonKey(name: "_id")
  String? get id => throw _privateConstructorUsedError;
  String get posterURL => throw _privateConstructorUsedError;
  String get posterPublicID => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get shortDescription => throw _privateConstructorUsedError;
  String? get longDescription => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  String? get registrationLink => throw _privateConstructorUsedError;
  String? get facebookPostURL => throw _privateConstructorUsedError;
  String get venue => throw _privateConstructorUsedError;

  /// Email of the responsible members for the event
  List<String> get contacts => throw _privateConstructorUsedError;

  /// Users who liked the event
  /// Emails are stored
  List<String> get liked => throw _privateConstructorUsedError;
  String get clubID => throw _privateConstructorUsedError;
  DateTime? get lastLocalUpdate => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventModelCopyWith<EventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventModelCopyWith<$Res> {
  factory $EventModelCopyWith(
          EventModel value, $Res Function(EventModel) then) =
      _$EventModelCopyWithImpl<$Res, EventModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String? id,
      String posterURL,
      String posterPublicID,
      String title,
      String shortDescription,
      String? longDescription,
      DateTime startDate,
      DateTime endDate,
      String? registrationLink,
      String? facebookPostURL,
      String venue,
      List<String> contacts,
      List<String> liked,
      String clubID,
      DateTime? lastLocalUpdate,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$EventModelCopyWithImpl<$Res, $Val extends EventModel>
    implements $EventModelCopyWith<$Res> {
  _$EventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? posterURL = null,
    Object? posterPublicID = null,
    Object? title = null,
    Object? shortDescription = null,
    Object? longDescription = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? registrationLink = freezed,
    Object? facebookPostURL = freezed,
    Object? venue = null,
    Object? contacts = null,
    Object? liked = null,
    Object? clubID = null,
    Object? lastLocalUpdate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      posterURL: null == posterURL
          ? _value.posterURL
          : posterURL // ignore: cast_nullable_to_non_nullable
              as String,
      posterPublicID: null == posterPublicID
          ? _value.posterPublicID
          : posterPublicID // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      shortDescription: null == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String,
      longDescription: freezed == longDescription
          ? _value.longDescription
          : longDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      registrationLink: freezed == registrationLink
          ? _value.registrationLink
          : registrationLink // ignore: cast_nullable_to_non_nullable
              as String?,
      facebookPostURL: freezed == facebookPostURL
          ? _value.facebookPostURL
          : facebookPostURL // ignore: cast_nullable_to_non_nullable
              as String?,
      venue: null == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String,
      contacts: null == contacts
          ? _value.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      liked: null == liked
          ? _value.liked
          : liked // ignore: cast_nullable_to_non_nullable
              as List<String>,
      clubID: null == clubID
          ? _value.clubID
          : clubID // ignore: cast_nullable_to_non_nullable
              as String,
      lastLocalUpdate: freezed == lastLocalUpdate
          ? _value.lastLocalUpdate
          : lastLocalUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventModelImplCopyWith<$Res>
    implements $EventModelCopyWith<$Res> {
  factory _$$EventModelImplCopyWith(
          _$EventModelImpl value, $Res Function(_$EventModelImpl) then) =
      __$$EventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "_id") String? id,
      String posterURL,
      String posterPublicID,
      String title,
      String shortDescription,
      String? longDescription,
      DateTime startDate,
      DateTime endDate,
      String? registrationLink,
      String? facebookPostURL,
      String venue,
      List<String> contacts,
      List<String> liked,
      String clubID,
      DateTime? lastLocalUpdate,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$EventModelImplCopyWithImpl<$Res>
    extends _$EventModelCopyWithImpl<$Res, _$EventModelImpl>
    implements _$$EventModelImplCopyWith<$Res> {
  __$$EventModelImplCopyWithImpl(
      _$EventModelImpl _value, $Res Function(_$EventModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? posterURL = null,
    Object? posterPublicID = null,
    Object? title = null,
    Object? shortDescription = null,
    Object? longDescription = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? registrationLink = freezed,
    Object? facebookPostURL = freezed,
    Object? venue = null,
    Object? contacts = null,
    Object? liked = null,
    Object? clubID = null,
    Object? lastLocalUpdate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$EventModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      posterURL: null == posterURL
          ? _value.posterURL
          : posterURL // ignore: cast_nullable_to_non_nullable
              as String,
      posterPublicID: null == posterPublicID
          ? _value.posterPublicID
          : posterPublicID // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      shortDescription: null == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String,
      longDescription: freezed == longDescription
          ? _value.longDescription
          : longDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      registrationLink: freezed == registrationLink
          ? _value.registrationLink
          : registrationLink // ignore: cast_nullable_to_non_nullable
              as String?,
      facebookPostURL: freezed == facebookPostURL
          ? _value.facebookPostURL
          : facebookPostURL // ignore: cast_nullable_to_non_nullable
              as String?,
      venue: null == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as String,
      contacts: null == contacts
          ? _value._contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      liked: null == liked
          ? _value._liked
          : liked // ignore: cast_nullable_to_non_nullable
              as List<String>,
      clubID: null == clubID
          ? _value.clubID
          : clubID // ignore: cast_nullable_to_non_nullable
              as String,
      lastLocalUpdate: freezed == lastLocalUpdate
          ? _value.lastLocalUpdate
          : lastLocalUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventModelImpl extends _EventModel with DiagnosticableTreeMixin {
  const _$EventModelImpl(
      {@JsonKey(name: "_id") this.id,
      required this.posterURL,
      required this.posterPublicID,
      required this.title,
      required this.shortDescription,
      this.longDescription,
      required this.startDate,
      required this.endDate,
      this.registrationLink,
      this.facebookPostURL,
      required this.venue,
      required final List<String> contacts,
      final List<String> liked = const [],
      required this.clubID,
      this.lastLocalUpdate,
      this.createdAt,
      this.updatedAt})
      : _contacts = contacts,
        _liked = liked,
        super._();

  factory _$EventModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventModelImplFromJson(json);

  @override
  @JsonKey(name: "_id")
  final String? id;
  @override
  final String posterURL;
  @override
  final String posterPublicID;
  @override
  final String title;
  @override
  final String shortDescription;
  @override
  final String? longDescription;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String? registrationLink;
  @override
  final String? facebookPostURL;
  @override
  final String venue;

  /// Email of the responsible members for the event
  final List<String> _contacts;

  /// Email of the responsible members for the event
  @override
  List<String> get contacts {
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contacts);
  }

  /// Users who liked the event
  /// Emails are stored
  final List<String> _liked;

  /// Users who liked the event
  /// Emails are stored
  @override
  @JsonKey()
  List<String> get liked {
    if (_liked is EqualUnmodifiableListView) return _liked;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_liked);
  }

  @override
  final String clubID;
  @override
  final DateTime? lastLocalUpdate;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EventModel(id: $id, posterURL: $posterURL, posterPublicID: $posterPublicID, title: $title, shortDescription: $shortDescription, longDescription: $longDescription, startDate: $startDate, endDate: $endDate, registrationLink: $registrationLink, facebookPostURL: $facebookPostURL, venue: $venue, contacts: $contacts, liked: $liked, clubID: $clubID, lastLocalUpdate: $lastLocalUpdate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EventModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('posterURL', posterURL))
      ..add(DiagnosticsProperty('posterPublicID', posterPublicID))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('shortDescription', shortDescription))
      ..add(DiagnosticsProperty('longDescription', longDescription))
      ..add(DiagnosticsProperty('startDate', startDate))
      ..add(DiagnosticsProperty('endDate', endDate))
      ..add(DiagnosticsProperty('registrationLink', registrationLink))
      ..add(DiagnosticsProperty('facebookPostURL', facebookPostURL))
      ..add(DiagnosticsProperty('venue', venue))
      ..add(DiagnosticsProperty('contacts', contacts))
      ..add(DiagnosticsProperty('liked', liked))
      ..add(DiagnosticsProperty('clubID', clubID))
      ..add(DiagnosticsProperty('lastLocalUpdate', lastLocalUpdate))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      __$$EventModelImplCopyWithImpl<_$EventModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventModelImplToJson(
      this,
    );
  }
}

abstract class _EventModel extends EventModel {
  const factory _EventModel(
      {@JsonKey(name: "_id") final String? id,
      required final String posterURL,
      required final String posterPublicID,
      required final String title,
      required final String shortDescription,
      final String? longDescription,
      required final DateTime startDate,
      required final DateTime endDate,
      final String? registrationLink,
      final String? facebookPostURL,
      required final String venue,
      required final List<String> contacts,
      final List<String> liked,
      required final String clubID,
      final DateTime? lastLocalUpdate,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$EventModelImpl;
  const _EventModel._() : super._();

  factory _EventModel.fromJson(Map<String, dynamic> json) =
      _$EventModelImpl.fromJson;

  @override
  @JsonKey(name: "_id")
  String? get id;
  @override
  String get posterURL;
  @override
  String get posterPublicID;
  @override
  String get title;
  @override
  String get shortDescription;
  @override
  String? get longDescription;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  String? get registrationLink;
  @override
  String? get facebookPostURL;
  @override
  String get venue;
  @override

  /// Email of the responsible members for the event
  List<String> get contacts;
  @override

  /// Users who liked the event
  /// Emails are stored
  List<String> get liked;
  @override
  String get clubID;
  @override
  DateTime? get lastLocalUpdate;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$EventModelImplCopyWith<_$EventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
