class Validator {
  /// Verifies if the provided email is valid
  static String? isEmailValid(String? email) {
    String? res = nullCheck(email, "email");
    if (res != null) {
      return res;
    }

    /// TODO: Implement it
    throw UnimplementedError();
  }

  static String? isScholarIDValid(String? scholarID) {
    /// TODO: Implement it
    throw UnimplementedError();
  }

  static String? nullCheck(String? value, String? fieldName) {
    if (value == null || value.isEmpty) {
      return "${fieldName ?? "field"} cannot be empty";
    }
    return null;
  }
}
