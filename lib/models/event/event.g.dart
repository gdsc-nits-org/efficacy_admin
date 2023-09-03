// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Event _$$_EventFromJson(Map<String, dynamic> json) => _$_Event(
      posterURL: json['posterURL'] as String,
      title: json['title'] as String,
      shortDescription: json['shortDescription'] as String,
      longDescription: json['longDescription'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      registrationLink: json['registrationLink'] as String,
      facebookPostURL: json['facebookPostURL'] as String?,
      venue: json['venue'] as String,
      contacts:
          (json['contacts'] as List<dynamic>).map((e) => e as String).toList(),
      liked:
          (json['liked'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      clubID: json['clubID'] as String,
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      'posterURL': instance.posterURL,
      'title': instance.title,
      'shortDescription': instance.shortDescription,
      'longDescription': instance.longDescription,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'registrationLink': instance.registrationLink,
      'facebookPostURL': instance.facebookPostURL,
      'venue': instance.venue,
      'contacts': instance.contacts,
      'liked': instance.liked,
      'clubID': instance.clubID,
    };
