import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomPhoneField extends StatelessWidget {
  final String? title;
  final bool enabled;
  final PhoneNumber? initialValue;
  final String? label;
  final EdgeInsets? contentPadding;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  const CustomPhoneField({
    super.key,
    this.title,
    this.enabled = true,
    this.initialValue,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.controller,
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
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            focusColor: const Color(0xFF05354C),
            contentPadding:
                contentPadding ?? const EdgeInsets.symmetric(horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),

            prefixIcon: Icon(prefixIcon,
                color: const Color.fromARGB(
                    255, 67, 67, 67)), //const Color(0xFF05354C),),
            suffixIcon: suffixIcon,
          ),
          enabled: enabled,
          initialCountryCode: initialValue?.countryISOCode ?? "IN",
          initialValue: initialValue?.number,
        ),
      ],
    );
  }
}
