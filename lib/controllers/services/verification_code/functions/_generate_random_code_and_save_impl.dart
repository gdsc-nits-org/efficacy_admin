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
    if (verificationCode.expiresAt.millisecondsSinceEpoch <
        DateTime.now().millisecondsSinceEpoch) {
      VerificationCodeModel newVerificationCode =
          newVerificationCodeModel(len, email);
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
        newVerificationCodeModel(len, email);
    res = await collection.insert(verificationCode.toJson());
    verificationCode = VerificationCodeModel.fromJson(
      Formatter.convertMapToMapStringDynamic(res)!,
    );

    return verificationCode;
  }
}

VerificationCodeModel newVerificationCodeModel(int len, String email) {
  DateTime expiresAt = DateTime.now().add(const Duration(days: 1));
  String code = VerificationCodeController.generateRandomCode(len);
  VerificationCodeModel verificationCode = VerificationCodeModel(
    email: email,
    code: code,
    expiresAt: expiresAt,
  );
  return verificationCode;
}
