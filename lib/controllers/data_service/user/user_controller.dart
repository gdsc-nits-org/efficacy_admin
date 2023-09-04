import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import 'package:efficacy_admin/models/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  const UserController._();

  static void _checkValidity() {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception("Error while signing in, please retry");
    }
  }

  static Future<void> create(UserModel user) async {
    await update(user);
  }

  static Future<UserModel?> get() async {
    _checkValidity();
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(Collections.users.name)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snapshot.data() != null) {
      return UserModel.fromJson(snapshot.data()! as Map<String, Object>);
    }
    return null;
  }

  static Future<void> update(UserModel user) async {
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
