import 'dart:math';

import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/services/mail/utils/verification_code_mail.dart';
import 'package:efficacy_admin/utils/database/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

part 'functions/_send_verification_code_mail_impl.dart';

class MailController {
  const MailController._();

  static Future<bool> sendVerificationCodeMail({
    required String code,
    required String email,
  }) {
    return _sendVerificationCodeMailImpl(code: code, email: email);
  }
}
