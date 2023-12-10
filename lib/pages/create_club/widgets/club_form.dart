import 'package:efficacy_admin/config/config.dart';
import 'package:efficacy_admin/controllers/services/user/user_controller.dart';
import 'package:efficacy_admin/pages/create_club/utils/create_club_utils.dart';
import 'package:efficacy_admin/pages/create_club/widgets/custom_field.dart';
import 'package:efficacy_admin/pages/create_event/widgets/url_input.dart';
import 'package:efficacy_admin/widgets/custom_phone_input/custom_phone_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/phone_number.dart';

class ClubForm extends StatelessWidget {
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
                hintText: "Institute Name",
                initialValue: "NIT, Silchar",
                enabled: false,
                icon: FontAwesomeIcons.institution,
                validator: (name) {
                  if (name!.isEmpty) {
                    return "institute name cannot be empty";
                  }
                  return null;
                },
              ),
              //club description
              CustomField(
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
                  initialValue: phoneNumber,
                  onPhoneChanged: onPhoneChanged,
                ),
              ),
              CustomField(
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
                controller: fbUrlController,
                icon: FontAwesomeIcons.facebook,
                hintText: 'Facebook page URL',
                validator: (value) {
                  return null;
                },
              ),
              //github link
              UrlInput(
                controller: githubUrlController,
                icon: FontAwesomeIcons.github,
                hintText: 'GitHub profile URL',
                validator: (value) {
                  return null;
                },
              ),
              //insta link
              UrlInput(
                controller: instaController,
                icon: FontAwesomeIcons.instagram,
                hintText: 'Instagram page URL',
                validator: (value) {
                  return null;
                },
              ),
              //linked in link
              UrlInput(
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
