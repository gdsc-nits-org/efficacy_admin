part of '../verification_code_controller.dart';

Future<VerificationCodeModel> _generateRandomCodeAndSaveImpl({
  required int len,
  required String email,
  required VerificationCodeIntent intent,
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
  selectorBuilder.eq(
    VerificationCodeFields.intent.name,
    intent.name,
  );
  Map? res = await collection.findOne(selectorBuilder);
  if (res != null) {
    VerificationCodeModel verificationCode = VerificationCodeModel.fromJson(
      Formatter.convertMapToMapStringDynamic(res)!,
    );
    if (verificationCode.expiresAt.millisecondsSinceEpoch <
        DateTime.now().millisecondsSinceEpoch) {
      VerificationCodeModel newVerificationCode =
          newVerificationCodeModel(len, email, intent);
      await collection.updateOne(
        selectorBuilder,
        compare(
          verificationCode.toJson(),
          newVerificationCode.toJson(),
        ).map,
      );
      verificationCode = newVerificationCode;
    }
    return verificationCode;
  } else {
    VerificationCodeModel verificationCode =
        newVerificationCodeModel(len, email, intent);
    WriteResult result = await collection.insertOne(verificationCode.toJson());
    res = result.document;
    verificationCode = VerificationCodeModel.fromJson(
      Formatter.convertMapToMapStringDynamic(res)!,
    );

    return verificationCode;
  }
}

VerificationCodeModel newVerificationCodeModel(
  int len,
  String email,
  VerificationCodeIntent intent,
) {
  DateTime expiresAt = DateTime.now().add(const Duration(days: 1));
  String code = VerificationCodeController.generateRandomCode(len);
  VerificationCodeModel verificationCode = VerificationCodeModel(
    email: email,
    code: code,
    intent: intent,
    expiresAt: expiresAt,
  );
  return verificationCode;
}
