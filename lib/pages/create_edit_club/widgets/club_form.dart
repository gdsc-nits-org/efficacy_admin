import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/pages/create_edit_club/utils/create_edit_club_utils.dart';
import 'package:efficacy_admin/pages/create_edit_club/widgets/custom_field.dart';
import 'package:efficacy_admin/pages/create_event/widgets/url_input.dart';
import 'package:efficacy_admin/widgets/custom_phone_input/custom_phone_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/phone_number.dart';

class ClubForm extends StatelessWidget {
  final bool editMode;
  final GlobalKey<FormState> formKey;
  final ScrollController scrollController;
  final TextEditingController nameController;
  final TextEditingController descController;
  final TextEditingController githubUrlController;
  final TextEditingController fbUrlController;
  final TextEditingController instaController;
  final TextEditingController linkedinController;
  final TextEditingController emailController;
  final PhoneNumber? phoneNumber;
  final void Function(PhoneNumber?) onPhoneChanged;

  const ClubForm({
    super.key,
    required this.editMode,
    required this.formKey,
    required this.scrollController,
    required this.nameController,
    required this.descController,
    required this.githubUrlController,
    required this.fbUrlController,
    required this.instaController,
    required this.linkedinController,
    required this.emailController,
    required this.phoneNumber,
    required this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    // prepareData();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              //Name
              CustomField(
                enabled: editMode,
                controller: nameController,
                hintText: 'Club Name',
                icon: Icons.title,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),
              //institute name
              CustomField(
                enabled: editMode,
                hintText: "Institute Name",
                initialValue: "NIT, Silchar",
                icon: FontAwesomeIcons.buildingColumns,
                validator: (name) {
                  if (name!.isEmpty) {
                    return "institute name cannot be empty";
                  }
                  return null;
                },
              ),
              //club description
              CustomField(
                enabled: editMode,
                hintText: 'Club Description',
                validator: (value) {
                  if (value!.isEmpty) {
                    return "description cannot be empty";
                  }
                  return null;
                },
                icon: FontAwesomeIcons.alignLeft,
                controller: descController,
                maxLines: 6,
              ),
              //phone number
              Padding(
                padding: EdgeInsets.only(left: padding, right: padding),
                child: CustomPhoneField(
                  enabled: editMode,
                  initialValue: phoneNumber,
                  onPhoneChanged: onPhoneChanged,
                ),
              ),
              CustomField(
                enabled: editMode,
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                hintText: "email address",
                icon: Icons.mail,
                validator: (email) {
                  return null;
                },
              ),
              //facebook link
              UrlInput(
                enabled: editMode,
                controller: fbUrlController,
                icon: FontAwesomeIcons.facebook,
                hintText: 'Facebook page URL',
                validator: (value) {
                  return null;
                },
              ),
              //github link
              UrlInput(
                enabled: editMode,
                controller: githubUrlController,
                icon: FontAwesomeIcons.github,
                hintText: 'GitHub profile URL',
                validator: (value) {
                  return null;
                },
              ),
              //insta link
              UrlInput(
                enabled: editMode,
                controller: instaController,
                icon: FontAwesomeIcons.instagram,
                hintText: 'Instagram page URL',
                validator: (value) {
                  return null;
                },
              ),
              //linked in link
              UrlInput(
                enabled: editMode,
                controller: linkedinController,
                icon: FontAwesomeIcons.linkedinIn,
                hintText: 'LinkedIn page URL',
                validator: (value) {
                  return null;
                },
              ),
              //gap at the end
              SizedBox(
                height: endGap,
              )
            ].separate(padding),
          ),
        ),
      ),
    );
  }
}
