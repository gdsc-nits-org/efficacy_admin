import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/models/utils/constants.dart';
import 'package:efficacy_admin/widgets/custom_drop_down/custom_drop_down.dart';
import 'package:efficacy_admin/widgets/profile_image_viewer/profile_image_viewer.dart';
import 'package:flutter/material.dart';

class MiscStep extends StatelessWidget {
  final void Function(String? path) onImageChanged;
  final String? selectedDegree;
  final void Function(String? newDegree) onDegreeChanged;
  final String? selectedBranch;
  final void Function(String? newBranch) onBranchChanged;
  final List<String> institutes;
  final String? selectedInstitute;
  final void Function(String? newInstitute) onInstituteChanged;
  const MiscStep({
    super.key,
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.topLeft,
            child: const Text(
              "Additional Info. :",
              style: TextStyle(fontSize: 20),
            )),
        ProfileImageViewer(
          height: 100,
          onImageChange: onImageChanged,
        ),
        CustomDropDown(
          title: "Degree",
          items: Degree.values.map((degree) => degree.name).toList(),
          initialValue: selectedDegree,
          onItemChanged: onDegreeChanged,
        ),
        CustomDropDown(
          title: "Branch",
          items: Branch.values.map((branch) => branch.name).toList(),
          initialValue: selectedBranch,
          onItemChanged: onBranchChanged,
        ),
        CustomDropDown(
          title: "Institute",
          items: institutes,
          initialValue: selectedInstitute,
          onItemChanged: onInstituteChanged,
        ),
      ].separate(MediaQuery.of(context).size.height * 0.016),
    );
  }
}
