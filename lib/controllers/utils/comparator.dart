import 'package:mongo_dart/mongo_dart.dart';

/// NOTE: id and _id are ignored
ModifierBuilder compare(Map<String, dynamic> a, Map<String, dynamic> b,
    {List<String> ignore = const []}) {
  ModifierBuilder modify = ModifierBuilder();
  Set<String> keys = {};
  keys.addAll(a.keys);
  keys.addAll(b.keys);
  for (dynamic key in b.keys) {
    if (ignore.contains(key)) continue;
    if (key == "_id" || key == "id") continue;
    if (a[key] != b[key]) {
      modify.set(key, b[key]);
    }
  }
  return modify;
}
