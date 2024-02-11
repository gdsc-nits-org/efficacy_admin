part of '../mail_controller.dart';

Future<bool> _sendVerificationCodeMailImpl({
  required String code,
  required String email,
}) async {
  String username = dotenv.env[EnvValues.MAIL_USERNAME.name]!;
  String password = dotenv.env[EnvValues.MAIL_PASSWORD.name]!;

  SmtpServer smtpServer = gmail(username, password);

  Message message = Message()
    ..from = Address(username, 'Efficacy Admin')
    ..recipients.add(email)
    ..subject = 'Welcome to Efficacy Admin'
    ..html = generateVerificationEmail(
      "Efficacy Admin",
      code,
      Assets.efficacyAdminHostedImageUrl,
      dark.value.toRadixString(16),
    );

  try {
    await send(message, smtpServer);
    return true;
  } on MailerException catch (e) {
    return false;
  }
}
