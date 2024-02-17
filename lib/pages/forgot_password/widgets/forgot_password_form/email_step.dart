import 'package:efficacy_admin/utils/validator.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class EmailStep extends StatelessWidget {
  final TextEditingController emailController;
  final bool verificationCodeVerified;
  const EmailStep({
    super.key,
    required this.emailController,
    required this.verificationCodeVerified,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              child: const Text(
                "Account Details :",
                style: TextStyle(fontSize: 20),
              )),
          CustomTextField(
            label: "Email",
            height: MediaQuery.of(context).size.height * 0.075 + 8,
            prefixIcon: Icons.email,
            controller: emailController,
            validator: Validator.isEmailValid,
            enabled: !verificationCodeVerified,
          ),
        ],
      ),
    );
  }
}
