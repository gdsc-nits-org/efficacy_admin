import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/utils/utils.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class VerificationStep extends StatefulWidget {
  final TextEditingController verificationCodeController;
  final Future<void> Function() resendVerificationCode;
  final bool verificationCodeVerified;
  const VerificationStep({
    super.key,
    required this.verificationCodeController,
    required this.resendVerificationCode,
    required this.verificationCodeVerified,
  });

  @override
  State<VerificationStep> createState() => _VerificationStepState();
}

class _VerificationStepState extends State<VerificationStep> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: widget.verificationCodeVerified
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                Text(
                  "Your email was verified",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )
          : Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Verification Code :",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: widget.resendVerificationCode,
                      child: Text(
                        "Resend verification code",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              decoration: TextDecoration.underline,
                              color: dark,
                            ),
                      ),
                    ),
                    CustomTextField(
                      label: "Verification Code",
                      height: MediaQuery.of(context).size.height * 0.075,
                      prefixIcon: Icons.verified_user,
                      controller: widget.verificationCodeController,
                      validator: (val) =>
                          Validator.nullAndEmptyCheck(val, "verification code"),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
