import 'package:efficacy_admin/config/configurations/theme/utils/palette.dart';
import 'package:efficacy_admin/utils/validator.dart';
import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class VerificationCodeStep extends StatelessWidget {
  final TextEditingController verificationCodeController;
  final bool verificationCodeVerified;
  final Future<void> Function() resendVerificationCode;
  const VerificationCodeStep({
    super.key,
    required this.verificationCodeController,
    required this.verificationCodeVerified,
    required this.resendVerificationCode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: verificationCodeVerified
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
                      onPressed: resendVerificationCode,
                      child: Text(
                        "Resend verification code",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              decoration: TextDecoration.underline,
                              color: dark,
                              decorationColor: dark,
                            ),
                      ),
                    ),
                    CustomTextField(
                      label: "Verification Code",
                      keyboardType: TextInputType.number,
                      height: MediaQuery.of(context).size.height * 0.075 + 8,
                      prefixIcon: Icons.verified_user,
                      controller: verificationCodeController,
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
