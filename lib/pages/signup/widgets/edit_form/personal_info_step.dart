import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/utils/validator.dart';
import 'package:efficacy_admin/widgets/custom_phone_input/custom_phone_input.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';

class PersonalInfoStep extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController scholarIDController;
  final void Function(PhoneNumber? newPhnNo)? onPhnNoChanged;
  const PersonalInfoStep({
    super.key,
    required this.nameController,
    required this.scholarIDController,
    this.onPhnNoChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.topLeft,
            child: const Text(
              "Personal Information :",
              style: TextStyle(fontSize: 20),
            )),
        CustomTextField(
          controller: nameController,
          prefixIcon: Icons.person,
          label: "Name",
          height: MediaQuery.of(context).size.height * 0.09,
          validator: Validator.isNameValid,
        ),
        CustomTextField(
          controller: scholarIDController,
          prefixIcon: Icons.numbers,
          label: "Scholar ID",
          height: MediaQuery.of(context).size.height * 0.09,
          validator: Validator.isScholarIDValid,
        ),
        CustomPhoneField(
          helperText: "* Optional",
          onPhnNoChanged: onPhnNoChanged,
          label: "Phone No.",
        ),
      ].separate(MediaQuery.of(context).size.height * 0.02),
    );
  }
}
