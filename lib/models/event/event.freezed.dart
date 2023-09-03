// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  String get posterURL => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get shortDescription => throw _privateConstructorUsedError;
  String? get longDescription => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  String get registrationLink => throw _privateConstructorUsedError;
  String? get facebookPostURL => throw _privateConstructorUsedError;
  String get venue => throw _privateConstructorUsedError;

  /// Ids of the responsible members for the event
  List<String> get contacts => throw _privateConstructorUsedError;

  /// Users who liked the event
  List<String> get liked => throw _privateConstructorUsedError;
  String get clubID => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {String posterURL,
      String title,
      String shortDescription,
      String? longDescription,
      DateTime startDate,
      DateTime endDate,
      String registrationLink,
      String? facebookPostURL,
      String venue,
      List<String> contacts,
      List<String> liked,
      String clubID});
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posterURL = null,
    Object? title = null,
    Object? shortDescription = null,
    Object? longDescription = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? registrationLink = null,
    Object? facebookPostURL = freezed,
    Object? venue = null,
    Object? contacts = null,
    Object? liked = null,
    Object? clubID = null,
  }) {
    return _then(_value.copyWith(
      posterURL: null == posterURL
          ? _value.posterURL
          : posterURL // ignore: cast_nullable_to_non_nullable
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
      registrationLink: null == registrationLink
          ? _value.registrationLink
          : registrationLink // ignore: cast_nullable_to_non_nullable
              as String,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$_EventCopyWith(_$_Event value, $Res Function(_$_Event) then) =
      __$$_EventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String posterURL,
      String title,
      String shortDescription,
      String? longDescription,
      DateTime startDate,
      DateTime endDate,
      String registrationLink,
      String? facebookPostURL,
      String venue,
      List<String> contacts,
      List<String> liked,
      String clubID});
}

/// @nodoc
class __$$_EventCopyWithImpl<$Res> extends _$EventCopyWithImpl<$Res, _$_Event>
    implements _$$_EventCopyWith<$Res> {
  __$$_EventCopyWithImpl(_$_Event _value, $Res Function(_$_Event) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posterURL = null,
    Object? title = null,
    Object? shortDescription = null,
    Object? longDescription = freezed,
    Object? startDate = null,
    Object? endDate = null,
    Object? registrationLink = null,
    Object? facebookPostURL = freezed,
    Object? venue = null,
    Object? contacts = null,
    Object? liked = null,
    Object? clubID = null,
  }) {
    return _then(_$_Event(
      posterURL: null == posterURL
          ? _value.posterURL
          : posterURL // ignore: cast_nullable_to_non_nullable
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
      registrationLink: null == registrationLink
          ? _value.registrationLink
          : registrationLink // ignore: cast_nullable_to_non_nullable
              as String,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Event implements _Event {
  const _$_Event(
      {required this.posterURL,
      required this.title,
      required this.shortDescription,
      this.longDescription,
      required this.startDate,
      required this.endDate,
      required this.registrationLink,
      this.facebookPostURL,
      required this.venue,
      required final List<String> contacts,
      final List<String> liked = const [],
      required this.clubID})
      : _contacts = contacts,
        _liked = liked;

  factory _$_Event.fromJson(Map<String, dynamic> json) =>
      _$$_EventFromJson(json);

  @override
  final String posterURL;
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
  final String registrationLink;
  @override
  final String? facebookPostURL;
  @override
  final String venue;

  /// Ids of the responsible members for the event
  final List<String> _contacts;

  /// Ids of the responsible members for the event
  @override
  List<String> get contacts {
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contacts);
  }

  /// Users who liked the event
  final List<String> _liked;

  /// Users who liked the event
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
  String toString() {
    return 'Event(posterURL: $posterURL, title: $title, shortDescription: $shortDescription, longDescription: $longDescription, startDate: $startDate, endDate: $endDate, registrationLink: $registrationLink, facebookPostURL: $facebookPostURL, venue: $venue, contacts: $contacts, liked: $liked, clubID: $clubID)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Event &&
            (identical(other.posterURL, posterURL) ||
                other.posterURL == posterURL) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription) &&
            (identical(other.longDescription, longDescription) ||
                other.longDescription == longDescription) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.registrationLink, registrationLink) ||
                other.registrationLink == registrationLink) &&
            (identical(other.facebookPostURL, facebookPostURL) ||
                other.facebookPostURL == facebookPostURL) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            const DeepCollectionEquality().equals(other._contacts, _contacts) &&
            const DeepCollectionEquality().equals(other._liked, _liked) &&
            (identical(other.clubID, clubID) || other.clubID == clubID));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      posterURL,
      title,
      shortDescription,
      longDescription,
      startDate,
      endDate,
      registrationLink,
      facebookPostURL,
      venue,
      const DeepCollectionEquality().hash(_contacts),
      const DeepCollectionEquality().hash(_liked),
      clubID);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventCopyWith<_$_Event> get copyWith =>
      __$$_EventCopyWithImpl<_$_Event>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventToJson(
      this,
    );
  }
}

abstract class _Event implements Event {
  const factory _Event(
      {required final String posterURL,
      required final String title,
      required final String shortDescription,
      final String? longDescription,
      required final DateTime startDate,
      required final DateTime endDate,
      required final String registrationLink,
      final String? facebookPostURL,
      required final String venue,
      required final List<String> contacts,
      final List<String> liked,
      required final String clubID}) = _$_Event;

  factory _Event.fromJson(Map<String, dynamic> json) = _$_Event.fromJson;

  @override
  String get posterURL;
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
  String get registrationLink;
  @override
  String? get facebookPostURL;
  @override
  String get venue;
  @override

  /// Ids of the responsible members for the event
  List<String> get contacts;
  @override

  /// Users who liked the event
  List<String> get liked;
  @override
  String get clubID;
  @override
  @JsonKey(ignore: true)
  _$$_EventCopyWith<_$_Event> get copyWith =>
      throw _privateConstructorUsedError;
}
