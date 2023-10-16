import 'package:hive/hive.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ObjectIDAdapter implements TypeAdapter<ObjectId> {
  @override
  ObjectId read(BinaryReader reader) {
    return ObjectId.parse(reader.read());
  }

  @override
  int get typeId => 13;

  @override
  void write(BinaryWriter writer, ObjectId obj) {
    writer.writeString(obj.toHexString());
  }
}
