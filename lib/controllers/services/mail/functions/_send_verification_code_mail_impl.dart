part of '../mail_controller.dart';

Future<void> _sendVerificationCodeMailImpl({
  required String code,
  required String email,
}) async {
  String username = dotenv.env[EnvValues.MAIL_USERNAME.name]!;
  String password = dotenv.env[EnvValues.MAIL_PASSWORD.name]!;

  SmtpServer smtpServer = SmtpServer('smtp.gmail.com',
      username: username,
      password: password,
      port: 25,
      ignoreBadCertificate: true,
      ssl: false,
      allowInsecure: true);

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
    await send(message, smtpServer, timeout: const Duration(minutes: 1));
  } on MailerException catch (e) {
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
    throw Exception("Couldn't send code to your email");
  }
}
