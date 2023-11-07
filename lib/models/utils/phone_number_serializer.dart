import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneNumberSerializer
    implements JsonConverter<PhoneNumber?, Map<String, dynamic>?> {
  const PhoneNumberSerializer();

  @override
  PhoneNumber? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return PhoneNumber(
      number: json['number']!,
      countryCode: json['countryCode']!,
      countryISOCode: json['countryISOCode']!,
    );
  }

  @override
  Map<String, dynamic>? toJson(PhoneNumber? phoneNumber) {
    if (phoneNumber == null) return null;
    return {
      'number': phoneNumber.number,
      'countryCode': phoneNumber.countryCode,
      'countryISOCode': phoneNumber.countryISOCode,
    };
  }
}
