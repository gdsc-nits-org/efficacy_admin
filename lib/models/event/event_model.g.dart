// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventModel _$$_EventModelFromJson(Map<String, dynamic> json) =>
    _$_EventModel(
      id: const ObjectIdSerializer().fromJson(json['_id'] as String?),
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
      lastLocalUpdate: json['lastLocalUpdate'] == null
          ? null
          : DateTime.parse(json['lastLocalUpdate'] as String),
    );

Map<String, dynamic> _$$_EventModelToJson(_$_EventModel instance) =>
    <String, dynamic>{
      '_id': const ObjectIdSerializer().toJson(instance.id),
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
      'lastLocalUpdate': instance.lastLocalUpdate?.toIso8601String(),
    };
