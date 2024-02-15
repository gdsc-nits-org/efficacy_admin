import 'dart:math';

import 'package:efficacy_admin/controllers/utils/comparator.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/models/verification_code/verification_code_model.dart';
import 'package:efficacy_admin/utils/database/database.dart';
import 'package:efficacy_admin/utils/formatter.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'functions/_generate_random_code_impl.dart';
part 'functions/_generate_random_code_and_save_impl.dart';
part 'functions/_verify_code_impl.dart';

class VerificationCodeController {
  static const String _collectionName = "verificationCode";
  const VerificationCodeController._();

  static String generateRandomCode(int len) {
    return _generateRandomCodeImpl(len);
  }

  static Future<VerificationCodeModel> generateRandomCodeAndSave({
    required int len,
    required String email,
    required VerificationCodeIntent intent,
  }) async {
    return _generateRandomCodeAndSaveImpl(
      len: len,
      email: email,
      intent: intent,
    );
  }

  static Future<void> verifyCode({
    required String code,
    required String email,
  }) async {
    return _verifyCodeImpl(
      code: code,
      email: email,
    );
  }
}
