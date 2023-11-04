import 'package:efficacy_admin/pages/signup/widgets/edit_form/credentials_step.dart';
import 'package:efficacy_admin/pages/signup/widgets/edit_form/misc_step.dart';
import 'package:efficacy_admin/pages/signup/widgets/edit_form/personal_info_step.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';

class EditForm extends StatefulWidget {
  final int step;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confPasswordController;
  final TextEditingController nameController;
  final TextEditingController scholarIDController;
  final void Function(PhoneNumber? newPhnNo)? onPhnNoChanged;
  final void Function(String? newPath) onImageChanged;
  final String selectedDegree;
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
    required this.confPasswordController,
    required this.nameController,
    required this.scholarIDController,
    this.onPhnNoChanged,
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
        confPasswordController: widget.confPasswordController,
      );
    } else if (widget.step == 1) {
      return PersonalInfoStep(
        nameController: widget.nameController,
        scholarIDController: widget.scholarIDController,
        onPhnNoChanged: widget.onPhnNoChanged,
      );
    } else {
      return MiscStep(
        onImageChanged: widget.onImageChanged,
        selectedDegree: widget.selectedDegree,
        onDegreeChanged: widget.onDegreeChanged,
        selectedBranch: widget.selectedBranch,
        onBranchChanged: widget.onBranchChanged,
        institutes: widget.institutes,
        selectedInstitute: widget.selectedInstitute,
        onInstituteChanged: widget.onInstituteChanged,
      );
    }
  }
}
