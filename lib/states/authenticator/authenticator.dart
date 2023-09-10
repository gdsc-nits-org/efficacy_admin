import 'package:efficacy_admin/models/models.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Authenticator {
  static UserModel? _currentUser;
  const Authenticator._();

  static UserModel? get currentUser => _currentUser;
  static Future<void> setCurrentUser(UserModel? newUser) async {
    _currentUser = newUser;
  }

  /// TODO: Set it up for IOS
  ///
  /// Could have just made a dummy user with certain values like scholarID
  /// as default to empty string but can cause bugs
  static Future<GoogleSignInAccount> googleSignIn() async {
    GoogleSignInAccount? account = await GoogleSignIn().signIn();
    if (account == null) {
      throw Exception("Couldn't sign in'");
    }
    return account;
  }

  static Future<void> signOut() async {
    await GoogleSignIn().signOut();
  }
}
