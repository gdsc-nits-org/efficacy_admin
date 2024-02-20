part of '../app_info.dart';

Future<AppInfoModel> _getImpl() async {
  DbCollection collection =
      Database.instance.collection(AppInfoController._collectionName);

  Map<String, dynamic>? res = await collection.findOne();
  if (res == null) {
    throw Exception(
        "Please contact the developers. Some important contact informations are missing.");
  } else {
    return AppInfoModel.fromJson(Formatter.convertMapToMapStringDynamic(res)!);
  }
}
