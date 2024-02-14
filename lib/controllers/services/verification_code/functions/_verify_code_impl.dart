part of '../verification_code_controller.dart';

Future<void> _verifyCodeImpl({
  required String code,
  required String email,
}) async {
  DbCollection collection =
      Database.instance.collection(VerificationCodeController._collectionName);

  SelectorBuilder selectorBuilder = SelectorBuilder();
  selectorBuilder.eq(
    VerificationCodeFields.email.name,
    email,
  );
  selectorBuilder.eq(
    VerificationCodeFields.app.name,
    appName,
  );
  Map? res = await collection.findOne(selectorBuilder);

  if (res == null) {
    throw Exception("Could not find verification code for your $email");
  } else {
    VerificationCodeModel verificationCode = VerificationCodeModel.fromJson(
      Formatter.convertMapToMapStringDynamic(res)!,
    );
    if (verificationCode.expiresAt.millisecondsSinceEpoch <
        DateTime.now().millisecondsSinceEpoch) {
      throw Exception(
          "Verification code expired. Please request for a new code.");
    }
    if (verificationCode.code != code) {
      throw Exception("Wrong code. Please recheck");
    } else {
      await collection.deleteOne(selectorBuilder);
    }
  }
}
