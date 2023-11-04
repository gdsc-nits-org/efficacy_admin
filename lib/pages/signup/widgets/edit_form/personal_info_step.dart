import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/utils/validator.dart';
import 'package:efficacy_admin/widgets/custom_phone_input/custom_phone_input.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class PersonalInfoStep extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController scholarIDController;
  final TextEditingController phoneController;
  const PersonalInfoStep({
    super.key,
    required this.nameController,
    required this.scholarIDController,
    required this.phoneController,
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
          keyboardType: TextInputType.name,
        ),
        CustomTextField(
          controller: scholarIDController,
          prefixIcon: Icons.numbers,
          label: "Scholar ID",
          height: MediaQuery.of(context).size.height * 0.09,
          validator: Validator.isScholarIDValid,
          keyboardType: TextInputType.number,
        ),
        CustomPhoneField(
          controller: phoneController,
          label: "Phone No.",
        ),
      ].separate(MediaQuery.of(context).size.height * 0.02),
    );
  }
}
