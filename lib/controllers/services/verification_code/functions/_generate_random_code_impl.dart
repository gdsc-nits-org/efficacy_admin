part of '../verification_code_controller.dart';

String _generateRandomCodeImpl(int len) {
  Random random = Random();
  List<String> charset = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];
  String randomCode = "";
  for (int i = 0; i < len; i++) {
    randomCode += charset[random.nextInt(charset.length)];
  }
  return randomCode;
}
