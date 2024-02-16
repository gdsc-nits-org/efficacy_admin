import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/utils/validator.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class CredentialsStep extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  const CredentialsStep({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<CredentialsStep> createState() => _CredentialsStepState();
}

class _CredentialsStepState extends State<CredentialsStep> {
  bool hidePassword = true;
  bool hideConfPassword = true;
  IconData passVisibility = Icons.visibility;
  IconData confirmPasswordVisibility = Icons.visibility;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
          children: [
        Container(
            alignment: Alignment.topLeft,
            child: const Text(
              "New Credentials:",
              style: TextStyle(fontSize: 20),
            )),
        CustomTextField(
          hiddenText: hidePassword,
          height: MediaQuery.of(context).size.height * 0.075,
          label: "Create Password",
          prefixIcon: Icons.lock,
          suffixIcon: IconButton(
            onPressed: () {
              if (passVisibility == Icons.visibility) {
                setState(() {
                  passVisibility = Icons.visibility_off;
                  hidePassword = false;
                });
              } else {
                setState(() {
                  passVisibility = Icons.visibility;
                  hidePassword = true;
                });
              }
            },
            icon: Icon(
              passVisibility,
              color: const Color.fromARGB(255, 67, 67, 67),
            ),
          ),
          controller: widget.passwordController,
          validator: (value) => Validator.isPasswordValid(value),
        ),
        CustomTextField(
          hiddenText: hideConfPassword,
          controller: widget.confirmPasswordController,
          height: MediaQuery.of(context).size.height * 0.075,
          label: "Confirm Password",
          prefixIcon: Icons.lock,
          suffixIcon: IconButton(
              onPressed: () {
                if (confirmPasswordVisibility == Icons.visibility) {
                  setState(() {
                    confirmPasswordVisibility = Icons.visibility_off;
                    hideConfPassword = false;
                  });
                } else {
                  setState(() {
                    confirmPasswordVisibility = Icons.visibility;
                    hideConfPassword = true;
                  });
                }
              },
              icon: Icon(
                confirmPasswordVisibility,
                color: const Color.fromARGB(255, 67, 67, 67),
              )),
          validator: (value) => Validator.isConfirmPassword(
            widget.passwordController.text.toString(),
            value.toString(),
          ),
        ),
      ].separate(MediaQuery.of(context).size.height * 0.01)),
    );
  }
}
