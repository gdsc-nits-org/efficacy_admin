import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberSerializer
    implements JsonConverter<PhoneNumber, Map<String, String?>> {
  const PhoneNumberSerializer();

  @override
  PhoneNumber fromJson(Map<String, String?> json) {
    return PhoneNumber(
      phoneNumber: json['phoneNumber'],
      dialCode: json['dialCode'],
      isoCode: json['isoCode'],
    );
  }

  @override
  Map<String, String?> toJson(PhoneNumber phoneNumber) {
    return {
      'phoneNumber': phoneNumber.phoneNumber,
      'dialCode': phoneNumber.dialCode,
      'isoCode': phoneNumber.isoCode,
    };
  }
}
