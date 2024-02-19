class Validator {
  /// Verifies if the provided email is valid
  static String? isEmailValid(String? email) {
    String? res = nullAndEmptyCheck(email, "Email");
    if (res != null) {
      return res;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email!)) {
      return "Invalid email";
    }
    return null;
  }

  /// Verifies if the provided name is valid
  static String? isNameValid(String? name) {
    String? res = nullAndEmptyCheck(name, "Name");
    if (res != null) {
      return res;
    }
    //checks if name contains only letters and no numbers or symbols
    if (!RegExp(r'^[a-z A-Z]+$').hasMatch(name!)) {
      return "Invalid name";
    }
    return null;
  }

  /// Verifies if the provided scholar ID is valid
  static String? isScholarIDValid(String? scholarID) {
    String? res = nullAndEmptyCheck(scholarID, "Scholar ID");
    if (res != null) {
      return res;
    }
    //checks only for B.Tech students from year 2010 to 2023
    // if (!RegExp(r'^(1[0-9]|20|21|22|23)[1][1-6](?!000)[0-9]{3}$')
    //     .hasMatch(scholarID!)) {
    //   return "Invalid scholar ID";
    // }
    if (!RegExp(r'^(?!0)[0-9]{1,10}$').hasMatch(scholarID!)) {
      return "Invalid scholar ID";
    }
    return null;
  }

  //checks if field is null or empty
  static String? nullAndEmptyCheck(String? value, String? fieldName) {
    if (value == null || value.isEmpty) {
      return "${fieldName ?? "field"} cannot be empty";
    }
    return null;
  }

  static String? isPasswordValid(String? password) {
    String? res = nullAndEmptyCheck(password, "Password");
    if (res != null) {
      return res;
    }
    if (password!.length < 6) {
      return "Password cannot be shorter than 6 character";
    }
    return null;
  }

  static String? isConfirmPassword(String? password, String? confirmPassword) {
    String? res = nullAndEmptyCheck(confirmPassword, "Confirm Password");
    if (res != null) {
      return res;
    }

    if (password != confirmPassword) {
      return "Enter the correct password";
    }
    return null;
  }

  static String? isValidURL(String? url, {bool isMandatory = false}) {
    if (isMandatory) {
      String? msg = nullAndEmptyCheck(url, "URL");
      if (msg != null) return msg;
    }
    Uri uri = Uri.parse(url!);
    if (url.isNotEmpty) {
      if (!(uri.isAbsolute && uri.hasScheme && uri.hasAuthority)) {
        return "Invalid URL";
      }
    }
    return null;
  }
}
