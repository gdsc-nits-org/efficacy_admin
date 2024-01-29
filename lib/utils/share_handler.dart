import 'dart:io' show Directory, File;

import 'package:cloudinary/cloudinary.dart';
import 'package:efficacy_admin/models/event/event_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareHandler {
  const ShareHandler._();

  static Future<XFile?> downloadAndSaveImage(String imageUrl) async {
    try {
      Dio dio = Dio();
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      await dio.download(imageUrl, '$tempPath/$fileName.png');
      return XFile('$tempPath/$fileName.png');
    } catch (e) {
      debugPrint("Error downloading and saving image: $e");
      return null;
    }
  }

  static Future<void> deleteSavedImage(String fileName) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String path = '$tempPath/$fileName.png';
    File file = File(path);
    if (await file.exists()) {
      await file.delete(recursive: true);
    }
  }

  static Future<void> shareEvent(EventModel event) async {
    String title = event.title;
    String startDate = DateFormat('hh:mm, d MMM yyyy').format(event.startDate);
    String endDate = DateFormat('hh:mm, d MMM yyyy').format(event.endDate);
    String venue = event.venue;
    String? fbURL = event.facebookPostURL;
    String? registrationURL = event.registrationLink;
    XFile? savedImage;
    if (event.posterURL.isNotEmpty) {
      savedImage = await downloadAndSaveImage(event.posterURL);
    }
    try {
      List<XFile> images = [];
      if (savedImage != null) {
        images.add(savedImage);
      }
      String content = "$title\nFrom: $startDate\nTo: $endDate\nVenue: $venue";
      if (fbURL != null) {
        content += "\nCheck out our facebook page: \n$fbURL";
      }
      if (registrationURL != null) {
        content += "\nYou can register at: \n$registrationURL";
      }

      await Share.shareXFiles(images, text: content);
    } catch (e) {
      rethrow;
    } finally {
      if (savedImage != null) {
        await deleteSavedImage(savedImage.name);
      }
    }
  }
}
