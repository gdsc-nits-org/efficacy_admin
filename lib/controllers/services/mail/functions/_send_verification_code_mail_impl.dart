part of '../mail_controller.dart';

Future<void> _sendVerificationCodeMailImpl({
  required String code,
  required String email,
}) async {
  String sendMailUrl =
      MailController._backendBaseUrl + MailController._mailSendRoute;
  String mailServiceToken = dotenv.env[EnvValues.MAIL_SERVICE_TOKEN.name]!;

  Dio dio = Dio();

  Map body = {
    "to": email,
    "html": generateVerificationEmail(
      appName,
      code,
      Assets.efficacyAdminHostedImageUrl,
      dark.toHexCode(),
    ),
    "subject": "Verification code for sign up at $appName",
  };
  await dio.post(
    sendMailUrl,
    data: body,
    options: Options(
      headers: {
        "Authorization": "Bearer $mailServiceToken",
      },
    ),
  );
}
