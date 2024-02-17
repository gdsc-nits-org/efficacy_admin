part of '../user_controller.dart';

Future<String> _resetPasswordImpl({
  required String email,
  required String newPassword,
}) async {
  DbCollection collection =
      Database.instance.collection(UserController._collectionName);
  SelectorBuilder selectorBuilder = SelectorBuilder();

  selectorBuilder.eq(UserFields.app.name, appName);
  selectorBuilder.eq(UserFields.email.name, email);

  Map<String, dynamic>? res = await collection.findOne(selectorBuilder);
  if (res == null) {
    throw Exception("User not found.");
  }
  String passwordHashed = Encryptor.encrypt(
    newPassword,
    dotenv.env[EnvValues.ENCRYPTER_SALT.name]!,
  );
  UserModel oldUserData = UserModel.fromJson(
    Formatter.convertMapToMapStringDynamic(res)!,
  );
  UserModel newUserData = oldUserData.copyWith(password: passwordHashed);
  await collection.updateOne(
    selectorBuilder,
    compare(
      oldUserData.toJson(),
      newUserData.toJson(),
    ).map,
  );
  return newUserData.name;
}
