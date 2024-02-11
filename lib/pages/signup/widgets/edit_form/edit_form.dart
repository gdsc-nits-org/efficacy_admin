import 'dart:typed_data';

import 'package:efficacy_admin/pages/signup/widgets/edit_form/credentials_step.dart';
import 'package:efficacy_admin/pages/signup/widgets/edit_form/misc_step.dart';
import 'package:efficacy_admin/pages/signup/widgets/edit_form/personal_info_step.dart';
import 'package:efficacy_admin/pages/signup/widgets/edit_form/verification_code.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';

class EditForm extends StatefulWidget {
  final int step;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController verificationCodeController;
  final TextEditingController nameController;
  final TextEditingController scholarIDController;
  final void Function(PhoneNumber) onPhoneChanged;
  final void Function(Uint8List? img) onImageChanged;
  final String selectedDegree;
  final Uint8List? imageData;
  final void Function(String? newDegree) onDegreeChanged;
  final String selectedBranch;
  final void Function(String? newBranch) onBranchChanged;
  final List<String> institutes;
  final String selectedInstitute;
  final void Function(String? newInstitutions) onInstituteChanged;
  const EditForm({
    super.key,
    required this.step,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.verificationCodeController,
    required this.nameController,
    required this.scholarIDController,
    this.imageData,
    required this.onPhoneChanged,
    required this.onImageChanged,
    required this.selectedDegree,
    required this.onDegreeChanged,
    required this.selectedBranch,
    required this.onBranchChanged,
    required this.institutes,
    required this.selectedInstitute,
    required this.onInstituteChanged,
  });

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  @override
  Widget build(BuildContext context) {
    if (widget.step == 0) {
      return CredentialsStep(
        emailController: widget.emailController,
        passwordController: widget.passwordController,
        confirmPasswordController: widget.confirmPasswordController,
      );
    } 
    else if(widget.step == 1){
      return VerificationStep(
        verificationCodeController: widget.verificationCodeController
      );
    }
    else if (widget.step == 2) {
      return PersonalInfoStep(
        nameController: widget.nameController,
        scholarIDController: widget.scholarIDController,
        onPhoneChanged: widget.onPhoneChanged,
      );
    } 
    else {
      return MiscStep(
        onImageChanged: widget.onImageChanged,
        selectedDegree: widget.selectedDegree,
        onDegreeChanged: widget.onDegreeChanged,
        imageData: widget.imageData,
        selectedBranch: widget.selectedBranch,
        onBranchChanged: widget.onBranchChanged,
        institutes: widget.institutes,
        selectedInstitute: widget.selectedInstitute,
        onInstituteChanged: widget.onInstituteChanged,
      );
    }
  }
}
