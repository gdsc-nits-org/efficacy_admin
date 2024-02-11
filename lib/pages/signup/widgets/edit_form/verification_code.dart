import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/utils/utils.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class VerificationStep extends StatefulWidget {
  final TextEditingController verificationCodeController;
  const VerificationStep({
    super.key,
    required this.verificationCodeController,
  });

  @override
  State<VerificationStep> createState() => _VerificationStepState();
}

class _VerificationStepState extends State<VerificationStep> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.4,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: const Text(
              "Verification Code :",
              style: TextStyle(fontSize: 20),
            )),
          CustomTextField(
            label: "Verification Code",
            height: MediaQuery.of(context).size.height * 0.075,
            prefixIcon: Icons.verified_user,
            controller: widget.verificationCodeController,
            validator: Validator.isScholarIDValid,
          ),
        ].separate(MediaQuery.of(context).size.height * 0.02),
      ),
    );
  }
}