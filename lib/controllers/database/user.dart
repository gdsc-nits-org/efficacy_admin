import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants.dart';
import 'package:efficacy_admin/models/user/user.dart' as models;
import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  const UserController._();

  static void _checkValidity() {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception("Error while signing in, please retry");
    }
  }

  static Future<void> create(models.User user) async {
    await update(user);
  }

  static Future<models.User?> get() async {
    _checkValidity();
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(Collections.users.name)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snapshot.data() != null) {
      return models.User.fromJson(snapshot.data()! as Map<String, Object>);
    }
    return null;
  }

  static Future<void> update(models.User user) async {
    _checkValidity();
    await FirebaseFirestore.instance
        .collection(Collections.users.name)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(user.toJson());
  }

  static Future<void> delete() async {
    throw UnimplementedError();
  }
}
