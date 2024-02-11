part of '../verification_code_controller.dart';

Future<String> _generateRandomCodeAndSaveImpl({
  required int len,
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
  late String code;
  if (res != null) {
    VerificationCodeModel verificationCode = VerificationCodeModel.fromJson(
      Formatter.convertMapToMapStringDynamic(res)!,
    );
    code = verificationCode.code;
  } else {
    code = VerificationCodeController.generateRandomCode(len);
    await collection.insert(
      VerificationCodeModel(email: email, code: code).toJson(),
    );
  }
  return code;
}
