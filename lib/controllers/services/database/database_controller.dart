import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/models/models.dart';
import 'package:efficacy_admin/utils/utils.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class DatabaseController {
  const DatabaseController._();

  static void _userValidation(user) {
    if (Validator.isEmailValid(user.email) != null) {
      throw Exception("Invalid email");
    }
    if (Validator.isScholarIDValid(user.scholarID) != null) {
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
