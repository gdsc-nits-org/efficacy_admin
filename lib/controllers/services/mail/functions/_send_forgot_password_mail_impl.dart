part of '../mail_controller.dart';

Future<void> _sendForgotPasswordMailImpl({
  required String code,
  required String email,
  required DateTime expiresAt,
}) async {
  String sendMailUrl =
      MailController._backendBaseUrl + MailController._mailSendRoute;
  String mailServiceToken = dotenv.env[EnvValues.MAIL_SERVICE_TOKEN.name]!;

  Dio dio = Dio();

  Map body = {
    "to": email,
    "html": generateForgotPasswordEmail(
      appName,
      code,
      Assets.efficacyAdminHostedImageUrl,
      accent.toHexCode(),
      expiresAt,
    ),
    "subject": "Forgot Password request at $appName",
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
