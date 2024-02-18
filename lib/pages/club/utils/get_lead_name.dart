import 'package:efficacy_admin/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:efficacy_admin/utils/utils.dart';

Future<String?> getLeadName(BuildContext context) async {
  return await showDialog(
    context: context,
    useRootNavigator: false,
    builder: (BuildContext context) {
      return const LeadNameDialog();
    },
  );
}

class LeadNameDialog extends StatefulWidget {
  const LeadNameDialog({super.key});

  @override
  State<LeadNameDialog> createState() => _LeadNameDialogState();
}

class _LeadNameDialogState extends State<LeadNameDialog> {
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double fieldHeight = height * 0.09;

    return AlertDialog(
      title: const Text('Leader Name'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('What shall we call you?'),
            const SizedBox(height: 10),
            CustomTextField(
              label: "Position",
              height: fieldHeight,
              controller: nameController,
              keyboardType: TextInputType.text,
              validator: Validator.isNameValid,
              prefixIcon: Icons.person,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              Navigator.pop(context, nameController.text);
            }
          },
          child: const Text('Confirm', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
