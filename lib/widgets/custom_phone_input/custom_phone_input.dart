import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomPhoneField extends StatelessWidget {
  final String? title;
  final bool enabled;
  final PhoneNumber? initialValue;
  const CustomPhoneField({
    super.key,
    this.title,
    this.enabled = true,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        IntlPhoneField(
          enabled: enabled,
          initialCountryCode: initialValue?.countryISOCode ?? "IN",
          initialValue: initialValue?.number,
        ),
      ],
    );
  }
}
