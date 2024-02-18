import 'package:flutter/material.dart';

import 'credentials_step.dart';
import 'email_step.dart';
import 'verification_code_step.dart';

class ForgotPasswordForm extends StatelessWidget {
  final int step;
  final bool verificationCodeVerified;
  final TextEditingController emailController;
  final TextEditingController verificationCodeController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final Future<void> Function() resendVerificationCode;
  const ForgotPasswordForm({
    super.key,
    required this.step,
    required this.emailController,
    required this.verificationCodeController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.verificationCodeVerified,
    required this.resendVerificationCode,
  });

  @override
  Widget build(BuildContext context) {
    if (step == 0) {
      return EmailStep(
        emailController: emailController,
        verificationCodeVerified: verificationCodeVerified,
      );
    } else if (step == 1) {
      return VerificationCodeStep(
        verificationCodeController: verificationCodeController,
        verificationCodeVerified: verificationCodeVerified,
        resendVerificationCode: resendVerificationCode,
      );
    } else {
      return CredentialsStep(
        passwordController: passwordController,
        confirmPasswordController: confirmPasswordController,
      );
    }
  }
}
