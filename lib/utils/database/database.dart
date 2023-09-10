import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'constants.dart';

class Database {
  static Db? _db;
  const Database._();

  static Future<void> init() async {
    if (_db != null) return;

    String? url = dotenv.env[EnvValues.MONGO_URI.name];
    if (url == null) {
      // TODO: Edit it so that we get the error somewhere in mail or anywhere using analysis tools like sentry or firebase analysis
      throw Exception("Storage URI not found, please contact the developers");
    }

    _db = await Db.create(url);
    await _db!.open();
    return;
  }

  static Db get instance {
    if (_db == null) {
      // TODO: Edit it so that we get the error somewhere in mail or anywhere using analysis tools like sentry or firebase analysis
      throw Exception(
          "Couldn't initialize database, please contact the developers");
    }
    return _db!;
  }
}
