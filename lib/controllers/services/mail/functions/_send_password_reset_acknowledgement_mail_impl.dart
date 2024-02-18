part of '../mail_controller.dart';

Future<void> _sendPasswordResetAcknowledgementMailImpl({
  required String email,
  required String userName,
}) async {
  String sendMailUrl =
      MailController._backendBaseUrl + MailController._mailSendRoute;
  String mailServiceToken = dotenv.env[EnvValues.MAIL_SERVICE_TOKEN.name]!;

  Dio dio = Dio();

  Map body = {
    "to": email,
    "html": generatePasswordResetAcknowledgementEmail(
      appName,
      userName,
      Assets.efficacyAdminHostedImageUrl,
    ),
    "subject": "Password reset at $appName",
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
