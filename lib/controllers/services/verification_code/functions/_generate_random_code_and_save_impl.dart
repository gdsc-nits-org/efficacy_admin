part of '../verification_code_controller.dart';

Future<VerificationCodeModel> _generateRandomCodeAndSaveImpl({
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
    return verificationCode;
  } else {
    code = VerificationCodeController.generateRandomCode(len);
    VerificationCodeModel verificationCode = VerificationCodeModel(
      email: email,
      code: code,
    );
    Map<String, dynamic> res =
        await collection.insert(verificationCode.toJson());
    verificationCode = VerificationCodeModel.fromJson(
      Formatter.convertMapToMapStringDynamic(res)!,
    );

    return verificationCode;
  }
}
