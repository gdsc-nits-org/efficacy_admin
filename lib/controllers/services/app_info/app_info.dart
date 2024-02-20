import 'package:efficacy_admin/models/app_info/app_info_model.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'functions/_get_impl.dart';

class AppInfoController {
  const AppInfoController._();
  static const String _collectionName = "appInfo";

  static Future<AppInfoModel> get() async {
    return _getImpl();
  }
}
