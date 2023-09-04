import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authenticator {
  const Authenticator._();

  /// Set it up for IOS
  static Future<void> googleSignIn() async {
    GoogleSignInAccount? account = await GoogleSignIn().signIn();
    if (account == null) {
      throw Exception("Couldn't sign in'");
    }

    GoogleSignInAuthentication authentication = await account.authentication;
    AuthCredential credentials = GoogleAuthProvider.credential(
      idToken: authentication.idToken,
      accessToken: authentication.accessToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credentials);
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
