import 'package:efficacy_admin/pages/signup/widgets/edit_form/credentials_step.dart';
import 'package:efficacy_admin/pages/signup/widgets/edit_form/misc_step.dart';
import 'package:efficacy_admin/pages/signup/widgets/edit_form/personal_info_step.dart';
import 'package:flutter/material.dart';

class EditForm extends StatefulWidget {
  final int step;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController scholarIDController;
  final TextEditingController phoneController;
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
    required this.nameController,
    required this.scholarIDController,
    required this.phoneController,
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
      );
    } else if (widget.step == 1) {
      return PersonalInfoStep(
        nameController: widget.nameController,
        scholarIDController: widget.scholarIDController,
        phoneController: widget.phoneController,
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
