import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:efficacy_admin/config/configurations/assets/assets.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> getFeedBackData(UserFeedback feedback) async {
  pw.Document pdf = pw.Document();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  final font = await rootBundle.load(Assets.regularFontPath);
  final ttf = pw.Font.ttf(font);
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.ConstrainedBox(
                constraints: const pw.BoxConstraints(maxHeight: 700),
                child: pw.Image(
                  pw.MemoryImage(feedback.screenshot),
                ),
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("Device Info", style: pw.TextStyle(font: ttf)),
                  pw.Text(
                    "1. App: Admin",
                    style: pw.TextStyle(font: ttf),
                  ),
                  pw.Text(
                    "2. Device: ${androidInfo.model}",
                    style: pw.TextStyle(font: ttf),
                  ),
                  pw.Text(
                    "3. OS: Android",
                    style: pw.TextStyle(font: ttf),
                  ),
                  pw.Text(
                    "4. OS Release version: ${androidInfo.version.release}",
                    style: pw.TextStyle(font: ttf),
                  ),
                  pw.Text(
                    "5. SDK: ${androidInfo.version.sdkInt}",
                    style: pw.TextStyle(font: ttf),
                  ),
                  pw.Text(
                    "6. Brand: ${androidInfo.brand}",
                    style: pw.TextStyle(font: ttf),
                  ),
                  pw.Text(
                    "7. Hardware: ${androidInfo.hardware}",
                    style: pw.TextStyle(font: ttf),
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Text("Issue:", style: pw.TextStyle(font: ttf)),
          pw.SizedBox(height: 10),
          pw.Text(feedback.text, style: pw.TextStyle(font: ttf)),
        ];
      },
    ),
  );
  return await pdf.save();
}
