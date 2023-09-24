import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneNumberSerializer
    implements JsonConverter<PhoneNumber, Map<String, String?>> {
  const PhoneNumberSerializer();

  @override
  PhoneNumber fromJson(Map<String, String?> json) {
    return PhoneNumber(
      number: json['number']!,
      countryCode: json['countryCode']!,
      countryISOCode: json['countryISOCode']!,
    );
  }

  @override
  Map<String, String?> toJson(PhoneNumber phoneNumber) {
    return {
      'number': phoneNumber.number,
      'countryCode': phoneNumber.countryCode,
      'countryISOCode': phoneNumber.countryISOCode,
    };
  }
}
