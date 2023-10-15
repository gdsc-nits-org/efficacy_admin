import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ObjectIdSerializer implements JsonConverter<ObjectId?, String?> {
  const ObjectIdSerializer();

  @override
  ObjectId? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return ObjectId.parse(json);
    return json;
  }

  @override
  String? toJson(ObjectId? object) {
    return object?.toHexString();
  }
}
