import 'package:efficacy_admin/controllers/data_service/user/user_controller.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class DatabaseController {
  const DatabaseController._();

  static void _userValidation(user) {
    if (!Validator.isEmailValid(user.email)) {
      throw Exception("Invalid email");
    }
    if (!Validator.isScholarIDValid(user.scholarID)) {
      throw Exception("Invalid scholar ID");
    }
  }

  static Future<void> createUser({
    required String name,
    PhoneNumber? phoneNumber,
    required String email,
    required String scholarID,
    String? userPhotoURL,
    required Branch branch,
    required Degree degree,
    Map<Social, String> socials = const {},
    List<ClubPositionModel> positions = const [],
  }) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception("No logged in user, please log in again");
    }
    UserModel user = UserModel(
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      scholarID: scholarID,
      userPhoto: userPhotoURL,
      branch: branch,
      degree: degree,
      socials: socials,
      position: positions,
    );
    _userValidation(user);

    await UserController.create(user);
  }
}
